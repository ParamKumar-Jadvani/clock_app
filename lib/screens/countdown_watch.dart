import 'dart:async';

import 'package:clock_app/extensions.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int h = 0;
  int m = 0;
  int s = 0;
  bool isRunning = false;

  final TextEditingController hourController = TextEditingController();
  final TextEditingController minuteController = TextEditingController();
  final TextEditingController secondController = TextEditingController();

  void startCountdown(
      {required int hours, required int minutes, required int seconds}) async {
    setState(() {
      isRunning = true;
      h = hours;
      m = minutes;
      s = seconds;
    });

    void countdown() async {
      if (!isRunning || (h == 0 && m == 0 && s == 0)) {
        setState(() {
          isRunning = false;
        });
        return;
      }

      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          if (s > 0) {
            s--;
          } else if (m > 0) {
            s = 59;
            m--;
          } else if (h > 0) {
            m = 59;
            s = 59;
            h--;
          }

          countdown();
        });
      });
    }

    countdown();
  }

  void startTimer() {
    if (isRunning) {
      setState(() {
        isRunning = false;
      });
    } else {
      int hours =
          int.parse(hourController.text.isEmpty ? '0' : hourController.text);
      int minutes = int.parse(
          minuteController.text.isEmpty ? '0' : minuteController.text);
      int seconds = int.parse(
          secondController.text.isEmpty ? '0' : secondController.text);
      startCountdown(hours: hours, minutes: minutes, seconds: seconds);
    }
  }

  void resetTimer() {
    setState(() {
      h = 0;
      m = 0;
      s = 0;
      hourController.clear();
      minuteController.clear();
      secondController.clear();
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: hourController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hours',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                8.w,
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: minuteController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Minutes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                8.w,
                SizedBox(
                  width: 50,
                  child: TextField(
                    controller: secondController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Seconds',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            20.h,
            Text(
              "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: startTimer,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: Text(isRunning ? 'Pause' : 'Start'),
                ),
                TextButton.icon(
                  onPressed: resetTimer,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
