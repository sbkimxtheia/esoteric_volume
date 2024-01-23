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
  int successCount = 0;

  Stage? currentStage;

  void setRandomStage({
    Level? level,
  }) async {
    setState(() => currentStage = null);

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => currentStage = Stage(
          level ?? Level.random(),
          Random().nextInt(99) + 1,
        ));
  }

  @override
  void initState() {
    super.initState();
    setRandomStage();
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
                  Builder(builder: (context) {
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
                            SizedBox(height: 10),
                            Tooltip(
                              message: '현재 볼륨',
                              child: VolumeDisplay(
                                currentVolume,
                                color: currentVolume == null ||
                                        currentVolume == stage.volumeGoal
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
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutQuart,
                      child: stage == null
                          ? const Padding(
                              padding: EdgeInsets.all(20),
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : stage.level.createWidget(ControllerData(
                              onChanged: (newVolume) {
                                setState(() {
                                  stage.currentVolume = newVolume;
                                });
                              },
                            )),
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
                        text = '확인';
                        onPressed = setRandomStage;
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
          Text('passed $successCount'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                                appBar: AppBar(),
                                body: LevelSelector(
                                  onTap: (level) {
                                    Navigator.pop(context);
                                    setRandomStage(level: level);
                                  },
                                ),
                              )));
                },
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: setRandomStage,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Stage {
  final Level level;
  final int volumeGoal;
  int? currentVolume;

  Stage(this.level, this.volumeGoal);

  bool isCorrect() {
    return currentVolume == volumeGoal;
  }
}
