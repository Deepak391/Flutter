import 'package:demo/main.dart';
import 'package:flutter/material.dart';

String remark = '';
void remarkcalc(int score) {
  print('the score is $score');

  
  if (score == 100) {
    remark = 'Outstanding';
  } else if (score == 80) {
    remark = 'Excellent';
  } else if (score == 90) {
    remark = 'Very Good';
  } else if (score == 70) {
    remark = 'Good';
  } else if (score == 60) {
    remark = 'Above Average';
  } else if (score == 50) {
    remark = 'Average';
  } else if (score == 40) {
    remark = 'Pass';
  } else {
    remark = 'Need Imporvement';
  }
}

class Resultshow extends StatefulWidget {
  final int score;
  const Resultshow(this.score, {Key? key}) : super(key: key);
  @override
  State<Resultshow> createState() => _ResultshowState();
}

class _ResultshowState extends State<Resultshow> {
  @override
  Widget build(BuildContext context) {
  Color mainColor = Color(0xFF0D0D0D);
  

    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "You have Completed the Quiz",
              style: TextStyle(color: Colors.white, fontSize: 26.0),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Your Score : ${widget.score}",
              style: TextStyle(
                  color: Color.fromARGB(255, 236, 198, 28), fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Remarks: ${remark}",
              style: TextStyle(color: Colors.cyan, fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              height: 50,
              
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              color: Color(0xFF242B2E),
              textColor: Color.fromARGB(255, 235, 233, 233),
              child: Text(
                "Retry",
              ),
            )
          ],
        ),
      ),
    );
  }
}
