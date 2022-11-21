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
  var userInput = '';
  var answer = '0';

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
    iconTheme: IconThemeData(color: Color(0xFF57636C)),
    actions: [
    PopupMenuButton(
      
      //icon: Icon(Icons.more_vert,color: Color(0xFF57636C)),
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

  backgroundColor: Color(0xFFF1F4F8),
  body: Column(
  children: <Widget>[
		Expanded(
			child: Container(
			child: Column(
				mainAxisAlignment: MainAxisAlignment.spaceEvenly,
				children: <Widget>[
					Container(
					padding: EdgeInsets.all(20),
					alignment: Alignment.centerRight,
					child: Text(
						userInput,
						style: TextStyle(fontSize: 18, color: Color(0xFF57636C)),
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
    Expanded(
      child: Container(
        child: Align(alignment: Alignment.center,
        child: ElevatedButton(
          
          child: Icon(
            
                Icons.mic,
                size: 200,
              ),
              onPressed: (
                //ใส่ฟังก์ชัน Speech to text ตรงนี้
              ) {},
              style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(20),
  ),
        )
        ),
      )
    ),
  ],
  )
);
}
}