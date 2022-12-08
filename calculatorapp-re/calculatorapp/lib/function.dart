import 'botton.dart';
import 'main.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SET extends StatefulWidget {
  const SET({super.key});

  @override
  FirstScreen createState() => FirstScreen();
}

class FirstScreen extends State<SET> {
  var userInput = '';
  var answer = '';


// Array of button
  final List<String> buttons = [
    'AC',
    'C',
    '%',
    '/',
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
    ' ',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        title:
            const Text("", style: TextStyle(fontSize: 25, color: Color(0xFF57636C))),
        backgroundColor: const Color(0xFFF1F4F8),
        iconTheme: const IconThemeData(color: Color(0xFF57636C)),
        actions: [
          PopupMenuButton(
              //icon: Icon(Icons.more_vert,color: Color(0xFF57636C)),
              itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child:
                    Text("Speech", style: TextStyle(color: Color(0xFF57636C))),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("Calculator",
                    style: TextStyle(color: Color(0xFF57636C))),
              ),
            ];
          }, onSelected: (value) {
            if (value == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            } else if (value == 1) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const SET()));
            }
          }),
        ],
      ),
      backgroundColor: const Color(0xFFF1F4F8),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userInput,
                          style:
                              const TextStyle(fontSize: 18, color: Color(0xFF57636C)),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.centerRight,
                        child: Text(
                          answer,
                          style: const TextStyle(
                              fontSize: 30,
                              color: Color(0xFF101213),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ]),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  //color: Color.fromARGB(255, 24, 94, 186),
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[

                      GridView.builder(
                          shrinkWrap: true,
                          //padding: EdgeInsets.zero,
                          //physics: NeverScrollableScrollPhysics(),
                          itemCount: buttons.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 20.0,
                                  mainAxisSpacing: 8.0),
                          itemBuilder: (BuildContext context, int index) {
                            
                            MyButton(buttonsize: 2);
                            
                            // AC = All Clear Button
                            if (index == 0) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    userInput = '';
                                    answer = '0';
                                  });
                                },
                                buttonText: buttons[index],
                                color: Color(0xFF7BCFFF),
                                textColor: Color.fromARGB(255, 255, 255, 255),
                              );
                              //color: Color.fromARGB(255, 54, 186, 24);
                            }

                            // C = Delete Button
                            else if (index == 1) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    userInput = userInput.substring(
                                        0, userInput.length - 1);

                                    if (userInput.length > 0) {
                                      if (userInput[userInput.length - 1] ==
                                              buttons[15] ||
                                          userInput[userInput.length - 1] ==
                                              buttons[11] ||
                                          userInput[userInput.length - 1] ==
                                              buttons[7] ||
                                          userInput[userInput.length - 1] ==
                                              buttons[3]) {
                                        userInput = userInput;
                                        //answer = userInput[userInput.length];
                                      } else {
                                        equalPressed();
                                      }
                                    } else if (userInput.length == 0) {
                                      answer = '0';
                                    }
                                  });
                                },
                                buttonText: buttons[index],
                                color: Color(0xFF7BCFFF),
                                textColor: Color.fromARGB(255, 255, 255, 255),
                              );
                            }

                            // % Button
                            else if (index == 2) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    userInput += buttons[index];
                                    equalPressed();
                                  });
                                },
                                buttonText: buttons[index],
                                color: Color(0xFF7BCFFF),
                                textColor: Color.fromARGB(255, 255, 255, 255),
                              );
                            }

                            //go to home for mic
                            else if (index == 16) {
                              return FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.mic,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()),
                                      );
                                    },
                                  ));
                            }

                            // Equal_to Button
                            else if (index == 18) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    userInput += '.';
                                    equalPressed();
                                  });
                                },
                                buttonText: buttons[index],
                                color: Colors.white,
                                textColor: Color(0xFF101213),
                              );
                            }

                            //answer
                            else if (index == 19) {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    equalPressed();
                                    userInput = answer;
                                  });
                                },
                                buttonText: buttons[index],
                                color: Color(0xFFF8A3EB),
                                textColor: Colors.white,
                              );
                            }

                            // other buttons
                            else {
                              return MyButton(
                                buttontapped: () {
                                  setState(() {
                                    if (index == 15 ||
                                        index == 11 ||
                                        index == 7 ||
                                        index == 3) {
                                      userInput += buttons[index];
                                    } else {
                                      userInput += buttons[index];
                                      equalPressed();
                                    }
                                  });
                                },
                                buttonText: buttons[index],
                                color: isOperator(buttons[index])
                                    ? Color(0xFFF8A3EB)
                                    : Colors.white,
                                textColor: isOperator(buttons[index])
                                    ? Colors.white
                                    : Color(0xFF101213),
                              );
                            }
                          }),
                    ],
                  )),
            ),
          ],
        );
      }),
    );
  }

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    } /*else if( x == '?'){
    userInput = '4';
  }*/
    return false;
  }

// function to calculate the input operation
//เหลือแก้ปัญหา dot
  void equalPressed() {
    String finaluserinput(String str) {
      str = str.replaceAll('x', '*');
      str = str.replaceAll('%', '/100');
      return str;
    }

    String input = userInput;
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput(input));

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toStringAsFixed(4);

    //answer = exp.toString();
    //answer = eval.toString();
    //answer = j.toString();
    //toStringAsExponential(3);
  }
}
