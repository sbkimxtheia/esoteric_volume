import 'dart:async';

import 'package:esoteric_volume/controller/basic.dart';
import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class RotatingVolumeController extends VolumeController {
  final double speed;

  const RotatingVolumeController(super.data, {super.key, this.speed = 1});

  @override
  State<RotatingVolumeController> createState() => _RotatingVolumeControllerState();
}

class _RotatingVolumeControllerState extends State<RotatingVolumeController> {
  late final speed = widget.speed / 200;
  final interval = const Duration(milliseconds: 5);
  late Timer timer;
  double angle = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(interval, (timer) {
      setState(() {
        angle += speed;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 300,
      child: Transform.rotate(
        angle: angle,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: BasicVolumeController(widget.data),
        ),
      ),
    );
  }
}
