import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'screens/onboarding/onboding_screen.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() {
  runApp(const AttnKareManagerApp());
}

class AttnKareManagerApp extends StatelessWidget {
  const AttnKareManagerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        // body: testSplash(),
        body: OnbodingScreen(),
        // body: AnimatedScreen(),
      ),
    );
  }

  SafeArea testContainer() {
    return SafeArea(
      top: true,
      bottom: true,
      left: false,
      right: false,
      child: Container(
        color: Colors.green.shade400,
        width: 380.0,
        height: 480.0,
        child: Container(
          color: Colors.blue.shade200,
          margin: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              color: Colors.amber.shade700,
            ),
          ),
        ),
      ),
    );
  }

  Container testSplash() {
    return Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF99231),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Backgrounds/Spline.png',
                  width: 240,
                ),
                const SizedBox(
                  height: 44,
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
