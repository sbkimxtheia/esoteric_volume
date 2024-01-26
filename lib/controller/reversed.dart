import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class ReversedVolumeController extends VolumeController {
  const ReversedVolumeController(super.data, {super.key});

  @override
  State<ReversedVolumeController> createState() =>
      _ReversedVolumeControllerState();
}

class _ReversedVolumeControllerState extends State<ReversedVolumeController> {
  int current = 50;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Slider(
        value: current.toDouble(),
        divisions: 101,
        min: 0,
        max: 100,
        onChanged: (value) {
          setState(() {
            current = 100 - value.toInt();
            widget.onVolumeChanged(current);
          });
        },
      ),
    );
  }
}
