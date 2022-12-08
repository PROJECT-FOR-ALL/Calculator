import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
//             child: SizedBox(
//               width: 8,
//               height: 8,
//               child: ElevatedButton(
//                   onPressed: () => buttontapped,
//                   child: Center(
//                       child: FittedBox(
//                     fit: BoxFit.scaleDown,
//                     child: Text(
//                       buttonText,
//                       style: TextStyle(
//                         color: textColor,
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ))
//                   ,style: ElevatedButton.styleFrom(backgroundColor: color),
//                  ),
//             )));
//   }
// }

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
              ),),
            ),
          )),
        ),
      ),
    );
  }
}
