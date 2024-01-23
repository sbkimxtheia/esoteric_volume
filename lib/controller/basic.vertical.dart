import 'package:esoteric_volume/controller/basic.dart';
import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class BasicVolumeControllerVertical extends StatelessWidget {
  final ControllerData data;

  const BasicVolumeControllerVertical(
    this.data, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: BasicVolumeController(data),
    );
  }
}
