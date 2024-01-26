import 'package:flutter/material.dart';

class TextVolumeDisplay extends StatelessWidget {
  final int volume;
  final double bottomPadding;

  const TextVolumeDisplay(
    this.volume, {
    super.key,
    this.bottomPadding = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.volume_up),
        Text(
          '${volume ?? '?'}',
          style: const TextStyle(fontSize: 40),
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
