import 'dart:math';

import 'package:flutter/material.dart';

abstract class VolumeController extends StatefulWidget {
  final ControllerData data;

  const VolumeController(
    this.data, {
    super.key,
  });

  void onVolumeChanged(int newVolume) {
    data.onChanged(newVolume);
  }
}

class ControllerData {
  final VolumeChangeCallBack onChanged;
  final Random random;

  ControllerData({
    required this.onChanged,
    Random? random,
  }) : random = random ?? Random();
}

typedef VolumeChangeCallBack = void Function(int? newVolume);
