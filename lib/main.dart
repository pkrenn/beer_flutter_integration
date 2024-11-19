import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SwiftUIPipView(),
    );
  }
}

class SwiftUIPipView extends StatelessWidget {
  const SwiftUIPipView({super.key});

  static const platform = MethodChannel('com.lab73/beer');

  _sendBeer() async {
    try {
      await platform.invokeMethod<bool>('sendBeer');
    } on PlatformException catch (e) {
      debugPrint("Failed to get beer: '${e.message}'.");
    }
  }

  _startTimerForBeer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateBeer();
    });
  }

  _updateBeer() async {
    try {
      await platform.invokeMethod<bool>('updateBeer');
    } on PlatformException catch (e) {
      debugPrint("Failed to update beer: '${e.message}'.");
    }
  }

  _cancelBeer() async {
    try {
      await platform.invokeMethod<bool>('cancelBeer');
    } on PlatformException catch (e) {
      debugPrint("Failed to update beer: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                _sendBeer();
              },
              child: const Text("Get me some beer!"),
            ),
            TextButton(
              onPressed: () {
                _startTimerForBeer();
              },
              child: const Text("Update my beer!"),
            ),
            TextButton(
              onPressed: () {
                _cancelBeer();
              },
              child: const Text("Cancel my beer!"),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
