import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class GridVolumeController extends StatelessWidget {
  final ControllerData data;

  const GridVolumeController(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];
    for (int v = 1; v <= 101; v++) {
      items.add(TextButton(
        onPressed: () => data.onChanged(v),
        child: Text((v == 101 ? 0 : v).toString()),
      ));
    }
    return SizedBox(
      width: 480,
      height: 525,
      child: Expanded(
        child: GridView.count(
          shrinkWrap: true,
          childAspectRatio: 1,
          crossAxisCount: 10,
          children: items,
        ),
      ),
    );
  }
}
