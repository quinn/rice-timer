import 'dart:async';

import 'package:flutter/material.dart';

class BlinkingCircle extends StatefulWidget {
  final bool _on;
  final bool _blink;

  const BlinkingCircle({Key? key, required on, required blink})
      : _on = on,
        _blink = blink,
        super(key: key);

  @override
  State<BlinkingCircle> createState() => _BlinkingCircleState();
}

class _BlinkingCircleState extends State<BlinkingCircle> {
  Timer? _countdownTimer;
  bool _blinkState = false;

  @override
  initState() {
    super.initState();

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _blinkState = !_blinkState;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
            color: (widget._blink && _blinkState) || widget._on
                ? Colors.white
                : Colors.black),
      ),
    );
  }
}
