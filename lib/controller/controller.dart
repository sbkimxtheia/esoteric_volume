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

  ControllerData({
    required this.onChanged,
  });
}

typedef VolumeChangeCallBack = void Function(int? newVolume);
