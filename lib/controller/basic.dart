import 'package:esoteric_volume/controller/controller.dart';
import 'package:esoteric_volume/volume_extension.dart';
import 'package:flutter/material.dart';

class BasicVolumeController extends VolumeController {
  final double width, height;
  final int initialVolume;

  const BasicVolumeController(
    super.data, {
    this.width = 240,
    this.height = 30,
    this.initialVolume = 70,
    super.key,
  });

  @override
  State<BasicVolumeController> createState() => _BasicVolumeControllerState();
}

class _BasicVolumeControllerState extends State<BasicVolumeController> {
  //
  late int current = widget.initialVolume.stabilized();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Slider(
        value: current.toDouble(),
        divisions: 101,
        min: 0,
        max: 100,
        onChanged: (value) {
          setState(() {
            current = value.toInt();
            widget.onVolumeChanged(current);
          });
        },
      ),
    );
  }
}
