import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class TextInputVolumeController extends StatelessWidget {
  final ControllerData data;

  TextInputVolumeController(this.data, {super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.volume_up),
        SizedBox(
          width: 50,
          child: TextField(
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
            onChanged: (s) {
              data.onChanged(int.tryParse(s));
            },
          ),
        ),
      ],
    );
  }
}
