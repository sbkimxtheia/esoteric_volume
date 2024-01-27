import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class BinaryVolumeController extends StatelessWidget {
  final ControllerData data;

  const BinaryVolumeController(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.volume_up),
        const SizedBox(height: 15),
        SizedBox(
          width: 50,
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
            onChanged: (s) {
              int? vol;
              if (s.isNotEmpty) {
                final parsed = int.tryParse(s, radix: 2);
                if (parsed != null) {
                  vol = parsed;
                }
              }
              data.onChanged(vol);
            },
          ),
        ),
        SizedBox(height: 5),
        const Icon(Icons.looks_two_sharp, size: 20),
      ],
    );
  }
}
