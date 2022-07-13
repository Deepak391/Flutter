import 'package:demo/result_show.dart';
import 'package:flutter/material.dart';
import 'package:demo/questions_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int score = 0;
  Color mainColor = Color(0xFF0D0D0D);
  Color secondColor = Color(0xFF242B2E);

  PageController? _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Padding(
          padding: EdgeInsets.all(18.0),
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller!,
            itemCount: questions.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Quiz about space and science",
                    style: TextStyle(color: Colors.white, fontSize: 28.0), 
                  ),
                  SizedBox(height: 100,),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Question ${index + 1}/${questions.length}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 8.0,
                    thickness: 1.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    questions[index].question!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26.0,
                    ),
                  ),
                  SizedBox(
                    height: 35.0,
                  ),
                  for (int i = 0; i < questions[index].answer!.length; i++)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 18.0),
                      child: MaterialButton(
                        shape: StadiumBorder(),
                        color: secondColor,
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        onPressed: () {
                          if (questions[index]
                              .answer!
                              .entries
                              .toList()[i]
                              .value) {
                            score += 10;
                          } else {
                            score += 0;
                          }
                          if (index + 1 == questions.length) {
                            setState(() {
                              remarkcalc(score);
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Resultshow(score)));
                          } else {
                            _controller!.nextPage(
                                duration: Duration(milliseconds: 5),
                                curve: Curves.decelerate);
                            print(score);
                          }
                        },
                        child: Text(
                          questions[index].answer!.keys.toList()[i],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        )
      );
  }
}
