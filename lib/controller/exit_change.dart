import 'package:esoteric_volume/controller/basic.dart';
import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class ExitChangeVolumeController extends VolumeController {
  const ExitChangeVolumeController(super.data, {super.key});

  @override
  State<ExitChangeVolumeController> createState() => _ExitChangeVolumeControllerState();
}

class _ExitChangeVolumeControllerState extends State<ExitChangeVolumeController> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: BasicVolumeController(widget.data),
    );
  }
}
