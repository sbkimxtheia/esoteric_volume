import 'dart:async';
import 'dart:math';

import 'package:esoteric_volume/controller/controller.dart';
import 'package:esoteric_volume/level_selector.dart';
import 'package:esoteric_volume/levels.dart';
import 'package:esoteric_volume/volume_display.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Esoteric Volume Controllers',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int timerPeriod = 10;

  Widget? block;

  bool infMode = false;

  int successCount = 0;
  int elapsedMs = 0;
  final List<int> elapsedMsList = [];
  Timer? timer;
  Stage? currentStage;

  // region timer

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  void restartTimer() {
    if (elapsedMs != 0) {
      elapsedMsList.add(elapsedMs);
    }
    stopTimer();
    elapsedMs = 0;
    timer = Timer.periodic(
      const Duration(milliseconds: timerPeriod),
      (timer) => setState(() => elapsedMs += timerPeriod),
    );
  }

  // endregion

  Future changeStage(Stage stage, {Widget? splash}) async {
    // clear
    stopTimer();
    setState(() {
      block = splash;
      currentStage = null;
    });

    // wait
    await Future.delayed(const Duration(milliseconds: 800));

    // show
    restartTimer();
    setState(() {
      block = null;
      currentStage = stage;
    });
  }

  Future changeRandomStage({Level? level, Widget? splash}) => changeStage(randomStage(level), splash: splash);

  void onSuccess() async {
    await changeRandomStage(
        splash: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('소요시간', style: TextStyle(color: Colors.grey)),
        Text(
          '${(elapsedMs / 1000).toStringAsFixed(2)}s',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    ));
  }

  void skipStage() {
    changeRandomStage(splash: Text('스테이지 건너뜀'));
  }

  @override
  void initState() {
    super.initState();
    changeRandomStage(splash: Text('Welcome!'));
  }

  Stage randomStage([Level? level]) {
    return Stage.random(() => setState(() {}), level);
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  double getAverageMs() {
    final count = elapsedMsList.length;

    if (count == 0) return 0;

    final sum = elapsedMsList.fold(0, (p, c) => p + c);
    return sum / count;
  }

  @override
  Widget build(BuildContext context) {
    final stage = this.currentStage;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: Builder(builder: (context) {
                      if (stage == null) return const SizedBox();
                      final currentVolume = stage.currentVolume;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Tooltip(
                                message: '목표 볼륨',
                                child: VolumeDisplay(stage.volumeGoal),
                              ),
                              const SizedBox(height: 10),
                              Tooltip(
                                message: '현재 볼륨',
                                child: VolumeDisplay(
                                  currentVolume,
                                  color: currentVolume == null || currentVolume == stage.volumeGoal
                                      ? Colors.teal
                                      : currentVolume > stage.volumeGoal
                                          ? Colors.red
                                          : Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.9),
                          offset: const Offset(2, 2),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeOutQuart,
                      child: Builder(builder: (context) {
                        if (stage != null) {
                          return stage.widget;
                        }

                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: block ??
                              const SizedBox.square(
                                dimension: 30,
                                child: CircularProgressIndicator(),
                              ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Builder(builder: (context) {
                    String text = '';
                    void Function()? onPressed;

                    if (stage == null) {
                      text = '불러오는 중';
                    } //
                    else {
                      final current = stage.currentVolume;
                      if (stage.isCorrect()) {
                        text = '다음';
                        onPressed = onSuccess;
                      } else if (current == null) {
                        text = '볼륨을 설정해 주세요';
                      } else if (current < stage.volumeGoal) {
                        text = '볼륨이 너무 작습니다.';
                      } else {
                        text = '볼륨이 너무 큽니다.';
                      }
                    }

                    return TextButton(
                      onPressed: onPressed,
                      child: Text(text),
                    );
                  })
                ],
              ),
            ),
          ),
          Text('${(elapsedMs / 1000).toStringAsFixed(2)}s'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('passed $successCount'),
              Text(' / '),
              Text('평균 소요시간 ${(getAverageMs() / 1000).toStringAsFixed(2)}초'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.list),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: LevelSelector(
                                  onTap: (level) {
                                    Navigator.pop(context);
                                    changeRandomStage(level: level);
                                  },
                                ),
                              )));
                },
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: onSuccess,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Stage extends StatelessWidget {
  final Level level;
  final int volumeGoal;
  final void Function() onChanged;
  int? currentVolume;

  Stage(
    this.level,
    this.volumeGoal,
    this.onChanged,
  );

  Stage.random(void Function() onChanged, [Level? level])
      : this(
          level ?? Level.random(),
          Random().nextInt(99) + 1,
          onChanged,
        );

  bool isCorrect() {
    return currentVolume == volumeGoal;
  }

  late final controllerData = ControllerData(
    onChanged: (v) {
      currentVolume = v;
      onChanged();
    },
    random: Random(),
  );

  late final widget = level.createWidget(controllerData);

  @override
  Widget build(BuildContext context) {
    return widget;
  }
}
