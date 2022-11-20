import 'package:flutter/material.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {

// declaring variables
final color;
final textColor;
final buttonText;
final buttontapped;

//Constructor
MyButton({this.color, this.textColor, this.buttonText, this.buttontapped});

@override
Widget build(BuildContext context) {
	
  return GestureDetector(
	
	child: Padding(
		padding: const EdgeInsets.all(5),
		child: ClipRRect(
		borderRadius: BorderRadius.circular(70),
		child: Container(
			color: color,
			child: Center(
			child: Text(
				buttonText,
				style: TextStyle(
				color: textColor,
				fontSize: 25,
				fontWeight: FontWeight.bold,
				),
			),
			),
		),
		),
	),
	);
}


/*
	return ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    shape: CircleBorder(), //<-- SEE HERE
    padding: EdgeInsets.all(20),
  ),
  child: Container(
			color: color,
			child: Center(
			child: Text(
				buttonText,
				style: TextStyle(
				color: textColor,
				fontSize: 25,
				fontWeight: FontWeight.bold,
				),
			),
			),
		),
);
}
*/
}
