import 'dart:async';

import 'package:clock_app/extensions.dart';
import 'package:flutter/material.dart';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  int s = 0;
  int m = 0;
  int h = 0;
  bool isStart = false;
  List<String> laps = [];
  bool isRunning = false; // To control the recursive Future.delayed

  Future<void> startStopwatch() async {
    // Recursive function to update the stopwatch
    if (isRunning) {
      await Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          s++;
          if (s == 60) {
            s = 0;
            m++;
          }
          if (m == 60) {
            m = 0;
            h++;
          }
        });
        // Call the function recursively
        startStopwatch();
      });
    }
  }

  void startStopTimer() {
    if (isStart) {
      setState(() {
        isRunning = false;
      });
    } else {
      setState(() {
        isRunning = true;
        startStopwatch(); // Start the stopwatch
      });
    }
    setState(() {
      isStart = !isStart;
    });
  }

  void reset() {
    setState(() {
      isRunning = false;
      isStart = false;
      s = 0;
      m = 0;
      h = 0;
      laps.clear();
    });
  }

  void addLap() {
    setState(() {
      laps.add(
          '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}');
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stop Watch'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${h.toString().padLeft(2, '0')} : ${m.toString().padLeft(2, '0')} : ${s.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            20.h,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: startStopTimer,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(0, 40),
                    shape: const CircleBorder(),
                    elevation: 5.0,
                  ),
                  child: Icon(
                    isStart
                        ? Icons.pause_circle_outline_rounded
                        : Icons.play_arrow_rounded,
                    size: 27,
                  ),
                ),
                ElevatedButton(
                  onPressed: addLap,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(0, 40),
                    shape: const CircleBorder(),
                    elevation: 5.0,
                  ),
                  child: const Icon(
                    Icons.flag,
                    size: 25,
                  ),
                ),
                ElevatedButton(
                  onPressed: reset,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(0, 40),
                    shape: const CircleBorder(),
                    elevation: 5.0,
                  ),
                  child: const Icon(
                    Icons.restart_alt,
                    size: 27,
                  ),
                ),
              ],
            ),
            20.h,
            Expanded(
              child: ListView.builder(
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      "Lap ${index + 1}",
                      style: const TextStyle(
                        fontSize: 24, // Increase the font size for the title
                        fontWeight:
                            FontWeight.bold, // Optional: makes the text bold
                      ),
                    ),
                    trailing: Text(
                      laps[index],
                      style: const TextStyle(
                        fontSize: 24, // Increase the font size for the title
                        fontWeight:
                            FontWeight.bold, // Optional: makes the text bold
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
