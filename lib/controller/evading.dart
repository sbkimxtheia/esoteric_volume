import 'dart:math';

import 'package:esoteric_volume/controller/basic.dart';
import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class EvadingVolumeController extends VolumeController {
  const EvadingVolumeController(super.data, {super.key});

  @override
  State<EvadingVolumeController> createState() =>
      _EvadingVolumeControllerState();
}

class _EvadingVolumeControllerState extends State<EvadingVolumeController> {
  double? dimension;

  double x = 0;
  double y = 0;

  void moveRandomly() {
    setState(() {
      dimension = 500;
      x = getRandomAlign();
      y = getRandomAlign();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension ?? 200,
      height: dimension,
      child: MouseRegion(
        onExit: (ev) {
          dimension = null;
          x = 0;
          y = 0;
        },
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOutQuart,
          alignment: Alignment(x, y),
          child: MouseRegion(
            onEnter: (e) {
              moveRandomly();
            },
            child: BasicVolumeController(widget.data),
          ),
        ),
      ),
    );
  }

  static double getRandomAlign() {
    final abs = 0.3 + (Random().nextDouble() * 0.7);
    return Random().nextBool() ? abs : -abs;
  }
}
