import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class IncrementController extends VolumeController {
  const IncrementController(super.data, {super.key});

  @override
  State<IncrementController> createState() => _IncrementControllerState();
}

class _IncrementControllerState extends State<IncrementController> {
  int? volume;

  void add(int delta) {
    int newVolume = volume ?? 50;
    newVolume += delta;
    if (newVolume < 0) {
      newVolume = 0;
    }
    //
    else if (newVolume > 100) {
      newVolume = 100;
    }
    setState(() {
      volume = newVolume;
    });
    widget.data.onChanged(newVolume);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.volume_up),
        Text(
          '${volume ?? '?'}',
          style: const TextStyle(fontSize: 40),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(child: const Text('-'), onPressed: () => add(-1)),
            TextButton(child: const Text('+'), onPressed: () => add(1)),
          ],
        )
      ],
    );
  }
}
