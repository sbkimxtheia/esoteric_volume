import 'dart:math';

import 'package:esoteric_volume/controller/controller.dart';
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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

  void setRandomStage() async {
    setState(() => currentStage = null);

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => currentStage = Stage(
          Level.random(),
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
                      children: [
                        Column(
                          children: [
                            VolumeDisplay(stage.volumeGoal, labelText: '목표 볼륨'),
                            VolumeDisplay(
                              currentVolume,
                              labelText: '현재 볼륨',
                              color: currentVolume == null ||
                                      currentVolume == stage.volumeGoal
                                  ? Colors.teal
                                  : currentVolume > stage.volumeGoal
                                      ? Colors.red
                                      : Colors.orange,
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 30),
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
                  const SizedBox(height: 80),
                  TextButton(
                    onPressed:
                        stage?.isCorrect() == true ? setRandomStage : null,
                    child: const Text('확인'),
                  )
                ],
              ),
            ),
          ),
          Text('passed $successCount'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: setRandomStage,
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
