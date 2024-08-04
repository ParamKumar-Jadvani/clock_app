import 'dart:math';

import 'package:clock_app/extensions.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage({super.key});

  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  List<String> dialImages = [
    'lib/assets/images/dial-1.png',
    'lib/assets/images/dial-2.jpg',
    'lib/assets/images/dial-3.jpg'
  ];

  String selectedTheme = '';

  int s = DateTime.now().second;
  int m = DateTime.now().minute;
  int h = DateTime.now().hour;

  bool isAnalog = true;
  bool isStrap = false;

  void setTime() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        s = DateTime.now().second;
        m = DateTime.now().minute;
        h = DateTime.now().hour;
      });
      setTime();
    });
  }

  @override
  void initState() {
    super.initState();
    selectedTheme = dialImages[0];
    setTime();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Clock App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('stop_watch');
            },
            icon: const Icon(
              Icons.watch_later_rounded,
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, 'countdown_watch');
            },
            icon: const Icon(
              Icons.timer_rounded,
              color: Colors.black,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('John'),
              accountEmail: Text('example@gmail.com'),
              currentAccountPicture: CircleAvatar(
                foregroundImage: NetworkImage(
                    'https://ps.w.org/user-avatar-reloaded/assets/icon-256x256.png?rev=2540745'),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: dialImages.map((elem) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTheme = elem;
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.all(8.0),
                      child: Image(
                        image: AssetImage(elem),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            13.h,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Analog Dial',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Switch(
                      value: isAnalog,
                      onChanged: (val) {
                        if ((!val) && isAnalog) {
                          isStrap = true;
                          isAnalog = val;
                        } else {
                          isStrap = false;
                          isAnalog = val;
                        }
                        setState(() {});
                      }),
                ],
              ),
            ),
            7.h,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Strap Dial',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Switch(
                      value: isStrap,
                      onChanged: (val) {
                        if ((!val) && isStrap) {
                          isAnalog = true;
                          isStrap = val;
                        } else {
                          isAnalog = false;
                          isStrap = val;
                        }

                        setState(() {});
                      }),
                ],
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: isAnalog,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 350,
                    child: Image(
                      image: AssetImage(selectedTheme),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: s * (pi * 2) / 60,
                      child: Divider(
                        color: Colors.red,
                        thickness: 3,
                        indent: 40,
                        endIndent: size.width * 0.45 - 16,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: m * (pi * 2) / 60,
                      child: Divider(
                        color: Colors.black87,
                        thickness: 4.5,
                        indent: 80,
                        endIndent: size.width * 0.45 - 16,
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: pi / 2,
                    child: Transform.rotate(
                      angle: h * (pi * 2) / 12,
                      child: Divider(
                        color: Colors.black,
                        thickness: 6.5,
                        indent: 105,
                        endIndent: size.width * 0.45 - 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isStrap,
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: 5,
                      child: CircularProgressIndicator(
                        value: s / 60, // Make it indeterminate
                        strokeWidth: 0.5,
                        color: Colors.red,
                      ),
                    ),
                    Transform.scale(
                      scale: 7,
                      child: CircularProgressIndicator(
                        value: m / 60, // Make it indeterminate
                        strokeWidth: 1,
                        color: Colors.green,
                      ),
                    ),
                    Transform.scale(
                      scale: 9,
                      child: CircularProgressIndicator(
                        value: (h % 12) / 12, // Make it indeterminate
                        strokeWidth: 1.5,
                        color: Colors.blue,
                      ),
                    ),
                    // Transform.rotate(
                    //   angle: pi / 2,
                    //   child: Transform.rotate(
                    //     angle: s * (pi * 2) / 60,
                    //     child: Divider(
                    //       color: Colors.red,
                    //       thickness: 3,
                    //       indent: 40,
                    //       endIndent: size.width * 0.45 - 16,
                    //     ),
                    //   ),
                    // ),
                    // Transform.rotate(
                    //   angle: pi / 2,
                    //   child: Transform.rotate(
                    //     angle: m * (pi * 2) / 60,
                    //     child: Divider(
                    //       color: Colors.green,
                    //       thickness: 4.5,
                    //       indent: 80,
                    //       endIndent: size.width * 0.45 - 16,
                    //     ),
                    //   ),
                    // ),
                    // Transform.rotate(
                    //   angle: pi / 2,
                    //   child: Transform.rotate(
                    //     angle: h * (pi * 2) / 12,
                    //     child: Divider(
                    //       color: Colors.blue,
                    //       thickness: 6.5,
                    //       indent: 105,
                    //       endIndent: size.width * 0.45 - 16,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
