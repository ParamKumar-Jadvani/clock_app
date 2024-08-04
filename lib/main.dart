import 'package:clock_app/screens/countdown_watch.dart';
import 'package:clock_app/screens/stop_watch.dart';
import 'package:clock_app/screens/ui_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const ClockPage(),
        'stop_watch': (context) => const StopWatch(),
        'countdown_watch': (context) => const CountdownTimer(),
      },
    );
  }
}
