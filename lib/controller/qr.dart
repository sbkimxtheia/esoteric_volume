import 'dart:developer';
import 'dart:math' as math;

import 'package:esoteric_volume/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeVolumeController extends VolumeController {
  const QRCodeVolumeController(super.data, {super.key});

  @override
  State<QRCodeVolumeController> createState() => _QRCodeVolumeControllerState();
}

class _QRCodeVolumeControllerState extends State<QRCodeVolumeController> {
  late final int add1, mul2, add3;
  String? currentEncrypted;

  @override
  void initState() {
    super.initState();
    add1 = math.Random().nextInt(10) + 10;
    mul2 = math.Random().nextInt(5) + 2;
    add3 = math.Random().nextInt(10) - 5;
  }

  String encrypt(int num) {
    final enc = ((num + add1) * mul2) + add3;
    log('[QR] encrypted $num to $enc');
    return enc.toString();
  }

  int? decrypt(String str) {
    final parsed = int.tryParse(str);
    if (parsed == null) return null;
    return (((parsed - add3) / mul2) - add1).toInt();
  }

  @override
  Widget build(BuildContext context) {
    final currentEncrypted = this.currentEncrypted;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Builder(builder: (context) {
          if (currentEncrypted == null) {
            return SizedBox(
              width: 60,
              child: TextField(
                textAlign: TextAlign.center,
                onSubmitted: (s) {
                  setState(() {
                    final parsed = int.tryParse(s);
                    if (parsed != null && 0 <= parsed && parsed <= 100) {
                      this.currentEncrypted = encrypt(parsed);
                    } else {
                      this.currentEncrypted = null;
                    }
                  });
                },
              ),
            );
          }

          return SizedBox(
            width: 150,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      this.currentEncrypted = null;
                    });
                  },
                  child: QrImageView(
                    data: currentEncrypted,
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  onChanged: (s) {
                    final decr = decrypt(s);
                    widget.data.onChanged(decr ?? 0);
                  },
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
