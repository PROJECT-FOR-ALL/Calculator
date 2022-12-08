import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

// creating Stateless Widget for buttons
class MyButton extends StatelessWidget {
// declaring variables
  final color;
  final textColor;
  final buttonText;
  final buttontapped;
  final buttonsize;

//Constructor
  MyButton(
      {this.color,
      this.textColor,
      this.buttonText,
      this.buttontapped,
      this.buttonsize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(600),

        child: Container(
          color: color,
          child: Center(
              child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              buttonText,
              style: GoogleFonts.sourceCodePro(
                textStyle: TextStyle(
                color: textColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )
              )
              ,
            ),
          )),
        ),
      ),
    );

    // return Container(
    //   margin: EdgeInsets.all(10.0),
    //   child: SizedBox(
    //     width: 70,
    //     height: 70,
    //     child: ElevatedButton(
    //       child: Text(
    //           buttonText,
    //           style: GoogleFonts.sourceCodePro(
    //             textStyle: TextStyle(
    //             color: textColor,
    //             fontSize: 25,
    //             fontWeight: FontWeight.bold,
    //           )
    //           )
    //           ,
    //         ),
    //       onPressed: () {},
    //       style: ElevatedButton.styleFrom(
    //         primary: Color(0xFF7BCFFF),
    //         shape: CircleBorder(),
    //         padding: EdgeInsets.all(20),
    //       ),
    //     ),
    //   ),
    // );
  }
}
