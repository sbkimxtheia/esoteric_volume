import 'dart:math';

import 'package:esoteric_volume/controller/axis.dart';
import 'package:esoteric_volume/controller/basic.dart';
import 'package:esoteric_volume/controller/basic.vertical.dart';
import 'package:esoteric_volume/controller/binary.dart';
import 'package:esoteric_volume/controller/controller.dart';
import 'package:esoteric_volume/controller/evading.dart';
import 'package:esoteric_volume/controller/grid.dart';
import 'package:esoteric_volume/controller/increment.dart';
import 'package:esoteric_volume/controller/qr.dart';
import 'package:esoteric_volume/controller/random.dart';
import 'package:esoteric_volume/controller/reversed.dart';
import 'package:esoteric_volume/controller/rotating.dart';
import 'package:esoteric_volume/controller/staying.dart';
import 'package:esoteric_volume/controller/textfield.dart';
import 'package:esoteric_volume/controller/timing.dart';
import 'package:esoteric_volume/controller/vibrating.dart';
import 'package:flutter/material.dart';

import 'controller/rythm.dart';

class Level {
  final int number;
  final CreateControllerWidget _createWidget;

  Level._(this.number, this._createWidget);

  Widget createWidget(ControllerData data) {
    return _createWidget(data);
  }

  //

  static final _defs = <CreateControllerWidget>[
    (data) => BasicVolumeController(data),
    (data) => BasicVolumeControllerVertical(data),
    (data) => TextInputVolumeController(data),
    (data) => BasicVolumeController(data, width: 30),
    (data) => RotatedBox(quarterTurns: 3, child: BasicVolumeController(data, width: 30)),
    (data) => QRCodeVolumeController(data),
    (data) => IncrementController(data),
    (data) => RandomController(data),
    (data) => GridVolumeController(data, showText: true, showTooltip: false, shuffle: false),
    (data) => GridVolumeController(data, showText: true, showTooltip: false, shuffle: true),
    (data) => GridVolumeController(data, showText: false, showTooltip: true, shuffle: false),
    (data) => GridVolumeController(data, showText: false, showTooltip: true, shuffle: true),
    (data) => AxisVolumeController(data),
    (data) => TimingVolumeController(data, period: 30),
    (data) => TimingVolumeController(data, period: 15),
    (data) => TimingVolumeController(data, period: 8),
    (data) => VibratingVolumeController(data),
    (data) => RythmicController(data),
    (data) => RythmicController(data, intervalMs: 200),
    (data) => RythmicController(data, intervalMs: 100, maxAddi: 6),
    (data) => EvadingVolumeController(data),
    (data) => ReversedVolumeController(data),
    (data) => StayingVolumeController(data, sensitivity: 0.5),
    (data) => StayingVolumeController(data, sensitivity: 1.0),
    (data) => StayingVolumeController(data, sensitivity: 2.5),
    (data) => StayingVolumeController(data, sensitivity: 6.0),
    (data) => BinaryVolumeController(data),
    (data) => RotatingVolumeController(data),
    (data) => RotatingVolumeController(data, speed: 2),
    (data) => RotatingVolumeController(data, speed: 5),
    (data) => RotatingVolumeController(data, speed: 10),
  ];
  static int _counter = 0;
  static final levels = _defs.map((e) => Level._(_counter++, e)).toList();
  static final levelsCount = levels.length;

  static Level random() {
    return levels[Random().nextInt(Level.levelsCount)];
  }
}

typedef CreateControllerWidget = Widget Function(ControllerData data);
