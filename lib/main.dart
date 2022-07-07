import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tip calculator",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  num billAmount = 0,
      people = 1,
      tipPercentage = 0,
      tipAmount = 0,
      totalAmount = 0;

  void tipDecerement() {
    if (tipPercentage > 0) {
      setState(() {
        tipPercentage--;
      });
    }
  }

  void tipIncerement() {
    setState(() {
      tipPercentage++;
    });
  }

  void peopleDecerement() {
    if (people > 1) {
      setState(() {
        people--;
      });
    }
  }

  void peopleIncerement() {
    setState(() {
      people++;
    });
  }

  void calculate() {
    
    if (people == 1) {
      setState(() {
        tipAmount =
            num.parse((billAmount * (tipPercentage / 100)).toStringAsFixed(2));
        totalAmount = num.parse((billAmount + tipAmount).toStringAsFixed(2));
      });
    } else {
      setState(() {
        tipAmount = billAmount * (tipPercentage / 100);
        tipAmount = num.parse((tipAmount / people).toStringAsFixed(2));
        totalAmount =
            num.parse((billAmount + tipAmount * people).toStringAsFixed(2));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4CE6A),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/tip.png",
                height: 100,
                width: 100,
              ),
              Text(
                "Tip Calculator",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                onChanged: (val) {
                  billAmount = double.parse(val);
                },
                decoration: InputDecoration(hintText: "Bill Amount"),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Text("Tip"),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        tipDecerement();
                      },
                      child: Icon(Icons.remove_circle)),
                  SizedBox(
                    width: 8,
                  ),
                  Text("${tipPercentage} %"),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        tipIncerement();
                      },
                      child: Icon(Icons.add_circle)),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: <Widget>[
                  Text("People"),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        peopleDecerement();
                      },
                      child: Icon(Icons.remove_circle)),
                  SizedBox(
                    width: 8,
                  ),
                  Text("${people}"),
                  SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                      onTap: () {
                        peopleIncerement();
                      },
                      child: Icon(Icons.add_circle)),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  if (billAmount > 0) {
                    calculate();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    "Calculate",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              tipAmount != 0
                  ? Text("Tip: ${tipAmount} per person")
                  : Container(),
              SizedBox(
                height: 15,
              ),
              totalAmount != 0
                  ? Text("Total Amount: ${totalAmount}")
                  : Container(),
            ],
          )),
    );
  }
}
