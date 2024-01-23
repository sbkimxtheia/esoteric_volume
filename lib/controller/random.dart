import 'dart:math';

import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class RandomController extends VolumeController {
  const RandomController(super.data, {super.key});

  @override
  State<RandomController> createState() => _RandomControllerState();
}

class _RandomControllerState extends State<RandomController> {
  int? volume;

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
        const SizedBox(height: 20),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => setState(() {
            volume = Random().nextInt(101);
            widget.data.onChanged(volume);
          }),
        )
      ],
    );
  }
}
