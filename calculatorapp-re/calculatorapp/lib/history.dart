import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'voice.dart';
import 'calculate.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:stacked_page_view/stacked_page_view.dart';
import 'package:loop_page_view/loop_page_view.dart';

final Set<MaterialColor> colors = {
  Colors.blueGrey,
  Colors.blue,
  Colors.cyan,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.red,
  Colors.purple,
};

class PageHistory extends StatelessWidget {
  final List<bool> isSelected =
      colors.map((e) => e == colors.last ? true : false).toList();
  final LoopPageController controller = LoopPageController();

  // @override
  // Widget build(BuildContext context) {
  //   final int selectedIndex = isSelected.indexOf(
  //     isSelected.firstWhere((element) => element == true),
  //   );

  //   return MaterialApp(
  //       home: Scaffold(
  //           appBar: AppBar(
  //             title: Text('Loop Page View Demo'),
  //           ),
  //           body: Center(
  //             child: LoopPageView.builder(
  //                 itemCount: 2,
  //                 itemBuilder: (_, index) {
  //                   return Card(
  //                     child: Center(
  //                       child: Text('$index'),
  //                     ),
  //                   );
  //                 }),
  //           )));
  // }

  // Some RGB bling
//   final List<Color> colors = <Color>[
//     Colors.red,
//     Colors.blue,
//     Colors.yellow,
//     Colors.green,
//     Colors.purpleAccent,
//     Colors.orange
//   ];
//   //
//  final PageController pageController = PageController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('widget'),
//         ),
//         body: PageView.builder(
//           itemCount: 2,
//           //pageSnapping: false,
//           scrollDirection: Axis.vertical,
//           controller: pageController,
//           itemBuilder: (context, index) {
//             // Wrap the ` StackedPageView` inside the inside the ` PageView.builder `
//             return StackPageView(
//               controller: pageController,
//               index: index,
//               child: Container(
//                 color: (colors..shuffle()).first,
//                 child: Center(
//                   child: Text(
//                     '$index',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 25,
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         )
//         );
//   }

}

ListView listView() {
  return ListView.builder(
    padding: const EdgeInsets.only(top: 0),
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 20,
    shrinkWrap: true,
    itemBuilder: (context, index) => Card(
      color: Colors.white70,
      child: ListTile(
        leading: CircleAvatar(
          child: Text("$index"),
        ),
        title: const Text("Title"),
        subtitle: const Text("Subtitile"),
      ),
    ),
  );
}
