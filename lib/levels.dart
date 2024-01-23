import 'dart:math';

import 'package:esoteric_volume/controller/basic.dart';
import 'package:esoteric_volume/controller/basic.vertical.dart';
import 'package:esoteric_volume/controller/controller.dart';
import 'package:esoteric_volume/controller/qr.dart';
import 'package:esoteric_volume/controller/textfield.dart';
import 'package:flutter/material.dart';

class Level {
  final int level;
  final CreateControllerWidget _createWidget;

  Level(this.level, this._createWidget);

  Widget createWidget(ControllerData data) {
    return _createWidget(data);
  }

  //

  static final _defs = <CreateControllerWidget>[
    (data) => BasicVolumeController(data),
    (data) => BasicVolumeControllerVertical(data),
    (data) => TextInputVolumeController(data),
    (data) => BasicVolumeController(data, width: 30),
    (data) => RotatedBox(
        quarterTurns: 3, child: BasicVolumeController(data, width: 30)),
    (data) => QRCodeVolumeController(data),
  ];
  static int _counter = 1;
  static final levels = _defs.map((e) => Level(_counter++, e)).toList();
  static final levelsCount = levels.length;

  static Level random() {
    return levels[Random().nextInt(Level.levelsCount)];
  }
}

typedef CreateControllerWidget = Widget Function(ControllerData data);
