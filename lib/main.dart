import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
        height: 500,
        width: 500,
        child: UiKitView(
          viewType: 'swiftui_integration',
        ),
      ),
    );
  }
}
