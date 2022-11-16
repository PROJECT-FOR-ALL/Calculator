import 'package:flutter/material.dart';
import 'botton.dart';
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
	backgroundColor: Colors.white38,
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
						style: TextStyle(fontSize: 18, color: Colors.white),
					),
					),
					Container(
					padding: EdgeInsets.all(15),
					alignment: Alignment.centerRight,
					child: Text(
						answer,
						style: TextStyle(
							fontSize: 30,
							color: Colors.white,
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
						color: Color.fromARGB(255, 68, 164, 232),
						textColor: Color.fromARGB(255, 255, 255, 255),
					);
					}

          // C = Delete Button
					else if (index == 1) {
					return MyButton(
						buttontapped: () {
						setState(() {
							userInput =
								userInput.substring(0, userInput.length - 1);
						});
						},
						buttonText: buttons[index],
						color: Color.fromARGB(255, 68, 164, 232),
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
						color: Color.fromARGB(255, 68, 164, 232),
						textColor: Color.fromARGB(255, 255, 255, 255),
					);
					}
				
					// Equal_to Button
					else if (index == 19) {
					return MyButton(
						buttontapped: () {
						setState(() {
							equalPressed();
						});
						},
						buttonText: buttons[index],
						color: Colors.orange[700],
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
							? Color.fromARGB(255, 68, 164, 232)
							: Color.fromARGB(255, 255, 255, 255),
						textColor: isOperator(buttons[index])
							? Colors.white
							: Colors.black,
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
	String finaluserinput = userInput;
	finaluserinput = userInput.replaceAll('x', '*');

	Parser p = Parser();
	Expression exp = p.parse(finaluserinput);
	ContextModel cm = ContextModel();
	double eval = exp.evaluate(EvaluationType.REAL, cm);
	answer = eval.toString();
}
}