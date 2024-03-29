import 'function.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SET(),
    ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userInput = '';
  var answer = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text("",
              style: TextStyle(fontSize: 25, color: Color(0xFF57636C))),
          backgroundColor: Color(0xFFF1F4F8),
          iconTheme: IconThemeData(color: Color(0xFF57636C)),
          actions: [
            PopupMenuButton(

                //icon: Icon(Icons.more_vert,color: Color(0xFF57636C)),
                itemBuilder: (context) {
              return [
                PopupMenuItem<int>(
                  value: 0,
                  child: Text("Speech",
                      style: TextStyle(color: Color(0xFF57636C))),
                ),
                PopupMenuItem<int>(
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
                    context, MaterialPageRoute(builder: (context) => SET()));
              }
            }),
          ],
        ),
        backgroundColor: Color(0xFFF1F4F8),
        body: LayoutBuilder(builder: (context, constraints) {
          return Column(
            children: <Widget>[
              Expanded(
                //flex: 2,
                //child: FittedBox(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.centerRight,
                                child: Text(
                                  userInput,
                                  style: TextStyle(
                                      fontSize: 18, color: Color(0xFF57636C)),
                                ),
                              ),
                          Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.centerRight,
                              
                                child: Text(
                                  answer,
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Color(0xFF101213),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                        ]),
                  ),
                ),
                //)
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    //color: Colors.blue,
                    child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: const EdgeInsets.all(100),
                            child: ElevatedButton(
                              child:
                                  FittedBox(child: Icon(Icons.mic, size: 200)),
                              onPressed: () {
                                //ใส่ฟังก์ชัน Speech to text ตรงนี้
                              
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF7BCFFF),
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(20),
                              ),
                            ))),
                  )),
            ],
          );
        }));
  }

  void equalPressed() {
    String finaluserinput(String str) {
      str = str.replaceAll('x', '*');
      str = str.replaceAll('%', '/100*');
      return str;
    }

    Parser p = Parser();
    Expression exp = p.parse(finaluserinput(userInput));

    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toStringAsFixed(5);
    //answer = eval.toString();
    //answer = j.toString();
    //toStringAsExponential(3);
  }
}
