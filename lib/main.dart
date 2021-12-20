import 'package:flutter/material.dart';

import 'presentation/screens/walkthrough.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yoyo challenge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WalkThroughScreen(),
    );
  }
}
