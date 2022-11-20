import 'botton.dart';
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
	'?',
	'0',
	'.',
	'=',
];

@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: new AppBar(
		title: new Text("Calculator"),
	), //AppBar
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
			flex: 3,
			child: Container(
			child: GridView.builder(
				itemCount: buttons.length,
				gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
					crossAxisCount: 4),
				itemBuilder: (BuildContext context, int index) {
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
					}

          // C = Delete Button
					else if (index == 1) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput =	userInput.substring(0, userInput.length - 1);
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

						});
						},
						buttonText: buttons[index],
						color: Color(0xFF7BCFFF),
						textColor: Color.fromARGB(255, 255, 255, 255),
					);
					}
				
					// Equal_to Button
					else if (index == 18) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput += '.';
						});
						},
						buttonText: buttons[index],
						color: Colors.white,
						textColor: Color(0xFF101213),
					);
					}

          else if (index == 19) {
					return MyButton(
						buttontapped: () {
						setState(() {
							equalPressed();
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
							userInput += buttons[index];
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
				}), // GridView.builder
			),
		),
		],
	),
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
void equalPressed() {
  
  String finaluserinput(String str){
    str = str.replaceAll('x', '*');
    str = str.replaceAll('%', '/100');
    return str;
  }


	Parser p = Parser();
	Expression exp = p.parse(finaluserinput(userInput));
  
	ContextModel cm = ContextModel();
	double eval = exp.evaluate(EvaluationType.REAL, cm);
	answer = eval.toStringAsFixed(3);
  //toStringAsExponential(3);
}
}