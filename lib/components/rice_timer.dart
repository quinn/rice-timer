import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rice_timer/components/blinking_circle.dart';

class RiceTimer extends StatefulWidget {
  final String _title;

  const RiceTimer({Key? key, required title})
      : _title = title,
        super(key: key);

  @override
  State<RiceTimer> createState() => _RiceTimerState();
}

class _RiceTimerState extends State<RiceTimer> {
  final CountdownTimerController controller;
  int _endTime = 0;
  int _currentStep = 0;
  static const _steps = [1, 2, 3, 4, 5];

  _RiceTimerState() : controller = CountdownTimerController(endTime: 0);

  void initState() {
    super.initState();
    setState(() {
      controller.disposeTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Card(
            child: Row(
      children: [
        Expanded(
          child: RotatedBox(
            quarterTurns: 1,
            child: Container(
                padding: const EdgeInsets.all(10),
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(widget._title.toLowerCase(),
                        style: GoogleFonts.majorMonoDisplay()))),
          ),
        ),
        Flexible(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_currentStep == 5) {
                        _currentStep = 0;
                      } else {
                        _currentStep += 1;
                      }
                    });
                  },
                  child: Row(
                    children: _steps
                        .map((n) => BlinkingCircle(
                              blink:
                                  controller.isRunning && _currentStep + 1 == n,
                              on: _currentStep >= n,
                            ))
                        .toList(),
                  ),
                ),
              ),
              Row(children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.fill,
                    // child: Center(child: Text("00 : 45 : 00")),
                    child: CountdownTimer(
                      controller: controller,
                      endTime: 0,
                      endWidget: Center(
                          child: Text(
                        "00:45:00",
                        style: GoogleFonts.majorMonoDisplay(),
                      )),
                    ),
                  ),
                ),
                ButtonBar(
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _endTime = 0;
                            controller.endTime = _endTime;
                            controller.start();
                          });
                        },
                        child: const Text("reset")),
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _endTime = DateTime.now().millisecondsSinceEpoch +
                                1000 * 60 * 45;
                            controller.endTime = _endTime;
                            controller.start();
                          });
                        },
                        child: const Text("start")),
                  ],
                )
              ])
            ],
          ),
        ),
      ],
    )));
  }
}
