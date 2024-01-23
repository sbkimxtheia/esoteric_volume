import 'dart:async';
import 'dart:math';

import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class VibratingVolumeController extends VolumeController {
  const VibratingVolumeController(super.data, {super.key});

  @override
  State<VibratingVolumeController> createState() =>
      _VibratingVolumeControllerState();
}

class _VibratingVolumeControllerState extends State<VibratingVolumeController> {
  int current = 50;
  bool isVibrating = false;

  late final Timer timer;

  void set(int vol) {
    if (vol > 100) {
      vol = 100;
    } else if (vol < 0) {
      vol = 0;
    }

    setState(() {
      current = vol;
    });
    widget.data.onChanged(vol);
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (!isVibrating) return;
      final abs = Random().nextInt(3) + 1;
      int vol = current;
      vol += Random().nextBool() ? abs : -abs;
      set(vol);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Slider(
        max: 100,
        min: 0,
        divisions: 101,
        value: current.toDouble(),
        onChanged: (v) {
          set(v.toInt());
          isVibrating = true;
        },
      ),
    );
  }
}
