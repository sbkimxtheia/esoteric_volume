import 'dart:async';

import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class TimingVolumeController extends VolumeController {
  final int period;

  const TimingVolumeController(
    super.data, {
    this.period = 10,
    super.key,
  });

  @override
  State<TimingVolumeController> createState() => _TimingVolumeControllerState();
}

class _TimingVolumeControllerState extends State<TimingVolumeController> {
  Timer? timer;

  bool isIncreasing = true;
  int current = 50;

  void start() {
    timer = Timer.periodic(Duration(milliseconds: widget.period), (timer) {
      int newVolume = current + (isIncreasing ? 1 : -1);

      if (newVolume >= 100) {
        isIncreasing = false;
      } else if (newVolume <= 0) {
        isIncreasing = true;
      }

      setState(() {
        current = newVolume;
      });
      widget.data.onChanged(newVolume);
    });
  }

  void pause() {
    timer?.cancel();
    timer = null;
  }

  @override
  void initState() {
    super.initState();
    start();
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.volume_up),
        SizedBox(
          width: 70,
          child: Text(
            '${current ?? '?'}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 40),
          ),
        ),
        const SizedBox(height: 20),
        Builder(builder: (context) {
          final isRunning = timer != null;
          return IconButton(
            icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (true == timer?.isActive) {
                pause();
              } else {
                start();
              }
            },
          );
        })
      ],
    );
  }
}
