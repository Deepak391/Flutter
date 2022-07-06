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
        backgroundColor: const Color(0xFF50DBB4),
        appBar: AppBar(
          backgroundColor: const Color(0xFF38CC77),
          title: const Center( 
            child: Text("Hidden Secret", style: TextStyle(fontSize: 40, color: Color(0xFF242B2E)),)) ,
        ),
        body: const Center(
          child: Text("Welcome to 127.0.0.1", style: TextStyle(fontSize: 50, color: Color(0xFF12B0E8)),),
        ),
        floatingActionButton: FloatingActionButton( 
          onPressed: () => {}, backgroundColor: const Color(0xFF02B290),
          child: const Icon(Icons.favorite) , 
          ),
      ),
    );
  }
}