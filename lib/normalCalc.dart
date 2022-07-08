import 'package:demo/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var finalOutput = '';

  final List<String> buttons = [
    'C',
    '⟵',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '^',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFdfe6e9),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        userInput,
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.centerRight,
                      child: Text(finalOutput, style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return MyButton(
                      buttonTapped: () {
                        if (buttons[index] == 'C') {
                          setState(() {
                            userInput = '';
                            finalOutput = '';
                          });
                        } else if (buttons[index] == '⟵') {
                          setState(() {
                            userInput =
                                userInput.substring(0, userInput.length - 1);
                          });
                        } else if (buttons[index] == '÷') {
                          setState(() {
                            userInput += '/';
                          });
                        } else if (buttons[index] == '=') {
                          Parser p = Parser();
                          Expression exp = p.parse(userInput);
                          ContextModel cm = ContextModel();
                          num eval = exp.evaluate(EvaluationType.REAL, cm);
                          setState(() {
                            finalOutput = eval.toString();
                          });
                        } else if (buttons[index] == 'x') {
                          setState(() {
                            userInput += '*';
                          });
                        } else {
                          setState(() {
                            userInput += buttons[index];
                          });
                        }
                        ;
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Color(0xFF2d3436)
                          : Color.fromARGB(255, 89, 97, 99),
                      textcolor: isOperator(buttons[index])
                          ? Color.fromARGB(255, 209, 226, 231)
                          : Color.fromARGB(255, 233, 241, 243),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' ||
        x == '/' ||
        x == 'x' ||
        x == '+' ||
        x == '=' ||
        x == '⟵' ||
        x == '-' ||
        x == '÷' ||
        x == 'C') {
      return true;
    }
    return false;
  }
}
