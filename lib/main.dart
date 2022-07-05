import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome To My App'),
        ),
        body: const Center(
          child: Text('Hello, World', style: TextStyle(fontSize: 50, color: Colors.amberAccent) ),
          ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
    );
  }
}

