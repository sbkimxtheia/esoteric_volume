import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class StayingVolumeController extends VolumeController {
  final double sensitivity;

  const StayingVolumeController(
    super.data, {
    super.key,
    this.sensitivity = 1,
  });

  @override
  State<StayingVolumeController> createState() => _StayingVolumeControllerState();
}

class _StayingVolumeControllerState extends State<StayingVolumeController> {
  double currentVolume = 50;
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: expanded ? 40 : 15,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepOrangeAccent, Colors.lightBlue],
          transform: GradientRotation(1.57079633),
        ),
      ),
      child: area(1),
    );
  }

  Widget area(int adder) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeUpDown,
      onEnter: (e) => setState(() => expanded = true),
      onExit: (e) => setState(() => expanded = false),
      onHover: (e) {
        final dY = e.localDelta.dy;
        setState(() {
          final newInternalVolume = currentVolume - (dY * widget.sensitivity);
          currentVolume = newInternalVolume;
          widget.data.onChanged(newInternalVolume.toInt() % 100);
        });
      },
    );
  }
}
