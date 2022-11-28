// import 'botton.dart';
// import 'main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:sizer/sizer.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:math_expressions/math_expressions.dart';

// class SET extends StatefulWidget {
//   @override
//   FirstScreen createState() => FirstScreen();
// }

// class FirstScreen extends State<SET> {
//   @override
//   var userInput = '';
//   var answer = '';

//   static const List<IconData> _iconTypes = [
//     Icons.mic,
//   ];

// // Array of button
//   final List<String> buttons = [
//     'AC',
//     'C',
//     '%',
//     '/',
//     '7',
//     '8',
//     '9',
//     'x',
//     '4',
//     '5',
//     '6',
//     '-',
//     '1',
//     '2',
//     '3',
//     '+',
//     ' ',
//     '0',
//     '.',
//     '=',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottomOpacity: 0.0,
//         elevation: 0.0,
//         title:
//             Text("", style: TextStyle(fontSize: 25, color: Color(0xFF57636C))),
//         backgroundColor: Color(0xFFF1F4F8),
//         iconTheme: IconThemeData(color: Color(0xFF57636C)),
//         actions: [
//           PopupMenuButton(
//               //icon: Icon(Icons.more_vert,color: Color(0xFF57636C)),
//               itemBuilder: (context) {
//             return [
//               PopupMenuItem<int>(
//                 value: 0,
//                 child:
//                     Text("Speech", style: TextStyle(color: Color(0xFF57636C))),
//               ),
//               PopupMenuItem<int>(
//                 value: 1,
//                 child: Text("Calculator",
//                     style: TextStyle(color: Color(0xFF57636C))),
//               ),
//             ];
//           }, onSelected: (value) {
//             if (value == 0) {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => MyApp()));
//             } else if (value == 1) {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => SET()));
//             }
//           }),
//         ],
//       ),
//       backgroundColor: Color(0xFFF1F4F8),
//       body: LayoutBuilder(builder: (context, constraints) {
//         return Column(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.all(10),
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           userInput,
//                           style:
//                               TextStyle(fontSize: 18, color: Color(0xFF57636C)),
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(15),
//                         alignment: Alignment.centerRight,
//                         child: Text(
//                           answer,
//                           style: TextStyle(
//                               fontSize: 30,
//                               color: Color(0xFF101213),
//                               fontWeight: FontWeight.bold),
//                         ),
//                       )
//                     ]),
//               ),
//             ),
//             Expanded(
//               flex: 3,
//               child: Container(
//                   color: Color.fromARGB(255, 24, 94, 186),
//                   padding: EdgeInsets.only(left: 10, right: 10, bottom: 5),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: <Widget>[

//                       ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: buttons.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             if(index>=0 && index <4){
//                               child: Row(
//                                 children: [
//                                 Text(buttons[index])
//                               ],);
//                             }
//                             else if(index>3 && index <8){
//                               child: Row(
//                                 children: [
//                                 Text(buttons[index])
//                               ],);
//                             }
//                             else if(index>7 && index <12){
//                               child: Row(
//                                 children: [
//                                 Text(buttons[index])
//                               ],);
//                             }
//                             else if(index>11 && index <16){
//                               child: Row(
//                                 children: [
//                                 Text(buttons[index])
//                               ],);
//                             }else{
//                               child: Row(
//                                 children: [
//                                 Text(buttons[index])
//                               ],);
//                             }
//                           }),
//                     ],
//                   )),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   bool isOperator(String x) {
//     if (x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
//       return true;
//     } /*else if( x == '?'){
//     userInput = '4';
//   }*/
//     return false;
//   }

// // function to calculate the input operation
// //เหลือแก้ปัญหา dot
//   void equalPressed() {
//     String finaluserinput(String str) {
//       str = str.replaceAll('x', '*');
//       str = str.replaceAll('%', '/100');
//       return str;
//     }

//     String input = userInput;
//     Parser p = Parser();
//     Expression exp = p.parse(finaluserinput(input));

//     ContextModel cm = ContextModel();
//     double eval = exp.evaluate(EvaluationType.REAL, cm);
//     answer = eval.toStringAsFixed(4);

//     //answer = exp.toString();
//     //answer = eval.toString();
//     //answer = j.toString();
//     //toStringAsExponential(3);
//   }
// }