import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textcolor;
  final String buttonText;
  final buttonTapped;
  MyButton(
      {required this.buttonText,
      this.color,
      this.textcolor,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: color,
                child: Center(
                    child: Text(
                  buttonText,
                  style: TextStyle(color: textcolor, fontSize: 25),
                ),),
              ),
            ),
          ),
        ),
        onTap: buttonTapped,
      ),
    );
  }
}
