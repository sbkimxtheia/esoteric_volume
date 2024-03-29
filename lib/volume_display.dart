import 'package:flutter/material.dart';

class VolumeDisplay extends StatelessWidget {
  final String? labelText;
  final int? value;
  final Color color;

  const VolumeDisplay(
    int? value, {
    super.key,
    this.labelText,
    this.color = Colors.teal,
  }) : value = value != null && 0 <= value && value <= 100 ? value : null;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          labelText == null
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Text(labelText ?? ''),
                ),
          const Icon(
            Icons.volume_up,
          ),
          const SizedBox(width: 5),
          SizedBox(
            width: 150,
            child: LinearProgressIndicator(
              minHeight: 7,
              value: value == null ? 0 : value! / 100,
              color: color,
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 25,
            child: Text(value?.toString() ?? '?'),
          ),
        ],
      ),
    );
  }
}
