import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class GridVolumeController extends StatelessWidget {
  final ControllerData data;
  final bool shuffle, showText, showTooltip;
  late final List<Widget> items;

  GridVolumeController(
    this.data, {
    super.key,
    this.shuffle = false,
    this.showText = true,
    this.showTooltip = false,
  }) {
    final items = <Widget>[];
    for (int v = 0; v <= 100; v++) {
      items.add(Tooltip(
        message: showTooltip ? '$v' : '',
        child: TextButton(
          onPressed: () => data.onChanged(v),
          child: Text(
            showText ? v.toString() : ' ',
            maxLines: 1,
          ),
        ),
      ));
    }
    if (shuffle) {
      items.shuffle(data.random);
    }
    this.items = items;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 490,
      height: 525,
      child: GridView.count(
        childAspectRatio: 1,
        crossAxisCount: 10,
        children: items,
      ),
    );
  }
}
