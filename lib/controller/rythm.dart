import 'dart:async';

import 'package:esoteric_volume/TextVolumeDisplay.dart';
import 'package:esoteric_volume/controller/controller.dart';
import 'package:esoteric_volume/volume_extension.dart';
import 'package:flutter/material.dart';

class RythmicController extends VolumeController {
  final int intervalMs, maxAddi;

  const RythmicController(
    super.data, {
    super.key,
    this.intervalMs = 200,
    this.maxAddi = 3,
  });

  @override
  State<RythmicController> createState() => _RythmVolumeControllerState();
}

class _RythmVolumeControllerState extends State<RythmicController> {
  //
  late final int intervalMs = widget.intervalMs;
  late final int maxAdderAbs = widget.maxAddi;

  int currentVolume = 50;

  bool isIncreasing = true;
  int adder = 0;
  late Timer timer;

  bool isButtonExpanded = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      Duration(milliseconds: intervalMs),
      (t) => setState(() {
        // 0 1 2 3 2 1 0 -1 -2 -3
        adder += (isIncreasing ? 1 : -1);

        if (adder.abs() >= maxAdderAbs) {
          isIncreasing = !isIncreasing;
        }
      }),
    );
  }

  void add() {
    final vol = (currentVolume + adder).stabilized();
    setState(() {
      currentVolume = vol;
    });
    widget.data.onChanged(vol);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextVolumeDisplay(currentVolume),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                const BoxShadow(blurRadius: 3, offset: Offset(.5, .5))
              ]),
          child: Material(
            color: Colors.white,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(4),
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onHover: (b) {
                setState(() {
                  isButtonExpanded = b;
                });
              },
              onTap: add,
              child: AnimatedSize(
                duration: Duration(milliseconds: 200),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        child: TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: intervalMs ~/ 1.5),
                          curve: Curves.easeInOut,
                          tween: Tween(
                            begin: 0,
                            end: (adder + maxAdderAbs) / (maxAdderAbs * 2),
                          ),
                          builder: (BuildContext context, double value,
                              Widget? child) {
                            final isPositive = value >= 0.5;
                            return LinearProgressIndicator(
                              minHeight: 9,
                              value: value,
                              color: isPositive
                                  ? Colors.lightBlue
                                  : Colors.deepOrangeAccent,
                            );
                          },
                        ),
                      ),
                      isButtonExpanded
                          ? Padding(
                              padding: const EdgeInsets.all(3),
                              child: Text(
                                '${adder > 0 ? '+$adder' : adder}',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
