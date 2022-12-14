import 'package:calculatorapp/history.dart';

import 'botton.dart';
import 'voice.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class PageCalculate extends StatefulWidget {
  @override
  Calculate createState() => Calculate();
  final list;

  PageCalculate({this.list});
}

class Calculate extends State<PageCalculate> {
  var userInput = '0';
  var userInput2 = '';
  int count = 0;
  var answer = '0';
  var answer2 = '0';

  void initState() {
    super.initState();
    print(widget.list);
  }

  final TextEditingController _controller = TextEditingController();

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
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      body: PageView(children: <Widget>[
        LayoutBuilder(builder: (context, constraints) {
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
                            child: TextField(
                                controller: _controller,
                                showCursor: true,
                                readOnly: true,
                                textAlign: TextAlign.end,
                                decoration:
                                    InputDecoration.collapsed(hintText: ""))),
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: ScrollPhysics(),
                            //physics: FixedExtentScrollPhysics(),
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
                                      userInput = '0';
                                      answer = '0';
                                    });
                                    final updatedText = userInput;
                                    _controller.value =
                                        _controller.value.copyWith(
                                      text: updatedText,
                                      selection: TextSelection.collapsed(
                                          offset: updatedText.length),
                                    );
                                  },
                                  buttonText: buttons[index],
                                  color: Color(0xFF7BCFFF),
                                  textColor: Color.fromARGB(255, 255, 255, 255),
                                );
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
                                        } else {
                                          check();
                                          equalPressed();
                                        }
                                      } else if (userInput.length == 0) {
                                        answer = '0';
                                        userInput = '0';
                                      }
                                    });
                                    final updatedText = userInput;
                                    _controller.value =
                                        _controller.value.copyWith(
                                      text: updatedText,
                                      selection: TextSelection.collapsed(
                                          offset: updatedText.length),
                                    );
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
                                      check();
                                      equalPressed();
                                    });
                                    final updatedText = userInput;
                                    _controller.value =
                                        _controller.value.copyWith(
                                      text: updatedText,
                                      selection: TextSelection.collapsed(
                                          offset: updatedText.length),
                                    );
                                  },
                                  buttonText: buttons[index],
                                  color: Color(0xFF7BCFFF),
                                  textColor: Color.fromARGB(255, 255, 255, 255),
                                );
                              }

                              //go to PageVoice
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
                                              builder: (context) =>
                                                  PageVoice()),
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

                                      check();
                                      equalPressed();

                                      if (userInput == '0.') {
                                        answer = '0';
                                      }
                                    });
                                    final updatedText = userInput;
                                    _controller.value =
                                        _controller.value.copyWith(
                                      text: updatedText,
                                      selection: TextSelection.collapsed(
                                          offset: updatedText.length),
                                    );
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
                                      check();
                                      var n = userInput[userInput.length - 1];
                                      if (n == '+' ||
                                          n == '-' ||
                                          n == 'x' ||
                                          n == '/' ||
                                          n == '.') {
                                        userInput = userInput.substring(
                                            0, userInput.length - 1);
                                      }
                                      equalPressed();

                                      userInput = num.parse(answer).toString();
                                      final updatedText = userInput;
                                      _controller.value =
                                          _controller.value.copyWith(
                                        text: updatedText,
                                        selection: TextSelection.collapsed(
                                            offset: updatedText.length),
                                      );
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
                                        userInput += buttons[index].toString();
                                        check();
                                      } else {
                                        if (userInput.length == 1 &&
                                            userInput[0] == '0') {
                                          userInput = userInput.substring(
                                              0, userInput.length - 1);
                                          check();
                                        }

                                        userInput += buttons[index].toString();
                                        equalPressed();
                                        check();
                                        if (answer2 == '0' && answer == '') {
                                          answer = answer2;
                                        }
                                      }
                                    });

                                    final updatedText = userInput;
                                    _controller.value =
                                        _controller.value.copyWith(
                                      text: updatedText,
                                      selection: TextSelection.collapsed(
                                          offset: updatedText.length),
                                    );
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

        //listView(),
      ]));

  bool isOperator(String x) {
    if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void check() {
    userInput = userInput.replaceAll('//', '/');
    userInput = userInput.replaceAll('xx', 'x');
    userInput = userInput.replaceAll('++', '+');
    userInput = userInput.replaceAll('--', '-');
    userInput = userInput.replaceAll('%%', '%');
    userInput = userInput.replaceAll('++', '+');
    userInput = userInput.replaceAll('xx', 'x');
    userInput = userInput.replaceAll('x.', 'x0.');
    userInput = userInput.replaceAll('+.', '+0.');
    userInput = userInput.replaceAll('-.', '-0.');
    userInput = userInput.replaceAll('/.', '/0.');
    userInput = userInput.replaceAll('%.', '%');
    userInput = userInput.replaceAll('-+', '+');
    userInput = userInput.replaceAll('x+', '+');
    userInput = userInput.replaceAll('/+', '+');
    userInput = userInput.replaceAll('.+', '+');
    userInput = userInput.replaceAll('+-', '-');
    userInput = userInput.replaceAll('x-', '-');
    userInput = userInput.replaceAll('/-', '-');
    userInput = userInput.replaceAll('.-', '-');
    userInput = userInput.replaceAll('+x', 'x');
    userInput = userInput.replaceAll('-x', 'x');
    userInput = userInput.replaceAll('/x', 'x');
    userInput = userInput.replaceAll('.x', 'x');
    userInput = userInput.replaceAll('+/', '/');
    userInput = userInput.replaceAll('-/', '/');
    userInput = userInput.replaceAll('x/', '/');
    userInput = userInput.replaceAll('%/', '/');
    userInput = userInput.replaceAll('./', '/');
    userInput = userInput.replaceAll('+%', '%');
    userInput = userInput.replaceAll('-%', '%');
    userInput = userInput.replaceAll('x%', '%');
    userInput = userInput.replaceAll('/%', '%');
    userInput = userInput.replaceAll('.%', '%');
    userInput = userInput.replaceAll('..', '.');
    userInput = userInput.replaceAll('=.', '');
  }

// function to calculate the input operation
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

    if (eval == 0) {
      answer2 = '0';
    }

    answer =
        eval.toStringAsFixed(7).replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), '');
  }
}
