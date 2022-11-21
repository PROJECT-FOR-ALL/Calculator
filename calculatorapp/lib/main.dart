import 'botton.dart';
import 'home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
	  return MaterialApp(
	  debugShowCheckedModeBanner: false,
	  home: HomePage(),
	  ); // MaterialApp
  }
}

class HomePage extends StatefulWidget {
  @override
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
  	return Scaffold(
    appBar: AppBar(
    title: Text(
      "CalculatorForAll",
      style: TextStyle(
        fontSize: 25,
        color: Color(0xFF57636C)
        )
      ),

    backgroundColor: Color(0xFFF1F4F8),
    actions: [

          PopupMenuButton(
            
            itemBuilder: (context){
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
            },
            onSelected:(value){
              if(value == 0){
                  Navigator.push(context,
                   MaterialPageRoute(builder: (context)=>MyApp()));
              }else if(value == 1){
                  Navigator.push(context,
                   MaterialPageRoute(builder: (context)=>SET()));
              }
            }
          ),

    ],
  ),
);
}
}