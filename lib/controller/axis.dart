import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';

class AxisVolumeController extends VolumeController {
  const AxisVolumeController(super.data, {super.key});

  @override
  State<AxisVolumeController> createState() => _AxisVolumeControllerState();
}

class _AxisVolumeControllerState extends State<AxisVolumeController> {
  int h = 5;
  int v = 5;

  void set(int h, int v) {
    final vol = h * 10 + v;
    setState(() {
      this.h = h;
      this.v = v;
    });
    widget.data.onChanged(vol);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 350,
      child: Row(
        children: [
          Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: 50,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      max: 10,
                      min: 0,
                      value: h.toDouble(),
                      onChanged: (h) {
                        set(h.toInt(), v);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                SizedBox(
                  height: 50,
                  child: Slider(
                    max: 10,
                    min: 0,
                    value: v.toDouble(),
                    onChanged: (v) {
                      set(h, v.toInt());
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
