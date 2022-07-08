import 'package:flutter/material.dart';
// import 'tipCalc.dart';
import 'normalCalc.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator",
      home: Calculator(),
    );
  }
}

