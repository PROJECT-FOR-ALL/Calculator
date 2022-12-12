import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'voice.dart';
import 'calculate.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:stacked_page_view/stacked_page_view.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:flutter_collapsing_toolbar/flutter_collapsing_toolbar.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class PageHistory extends StatefulWidget {
  final history;
  PageHistory({this.history});

  History createState() => History();
}

class History extends State<PageHistory> {
  final LoopPageController controller = LoopPageController();

  final List<String> list = ['0'];
  var textHis;

  @override
  void initState() {
    super.initState();
    //textHis = widget.history;
    //list.add(textHis);
    //print(list);
  }

  void forhis() {
    textHis = widget.history;
    list.add(textHis);
    //print(list);
  }

  final _controller = ScrollController();
  double headerOffset = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return TextButton(
          child: Text(
            '$list[index]',
            style: TextStyle(fontSize: 25),
          ),
          style: TextButton.styleFrom(
              backgroundColor: Color(0),
              padding: EdgeInsets.all(10),
              side: BorderSide(color: Color.fromARGB(119, 129, 129, 129)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () {
            //print('Button pressed' + pushanswer.toString() );
          },
        );
      },
    )

        //   ListView(children: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
        //     child: ExpansionTileCard(
        //       title: Text('Tap me!'),
        //       //subtitle: Text('I expand!'),
        //       children: <Widget>[
        //         Divider(
        //           thickness: 1.0,
        //           //height: 50.0,
        //         ),
        //         Align(
        //           alignment: Alignment.centerLeft,
        //           child: Padding(
        //             padding: const EdgeInsets.symmetric(
        //               horizontal: 16.0,
        //               vertical: 10.0,
        //             ),
        //             child: ListView.builder(
        //                 itemCount: list.length,
        //                 itemBuilder: (context, index) {
        //                   return Text(
        //                     '${list[index]}',
        //                     style: TextStyle(fontSize: 25),
        //                   );
        //                 }),
        //           ),
        //         ),
        //       ],
        //     ),
        //   )
        // ] )
        );
  }

  navigate2Page(BuildContext context) async {}

  // appBar: AppBar(
  //   title: Text("ListView Example"),
  // ),

  //   body: DefaultTabController(
  //   length: 2,
  //   child: NestedScrollView(
  //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //       return <Widget>[
  //         SliverAppBar(
  //           expandedHeight: 500.0,
  //           floating: false,
  //           pinned: true,
  //           flexibleSpace: FlexibleSpaceBar(
  //               centerTitle: true,
  //               title: Text("Collapsing Toolbar",
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 16.0,
  //                   )),
  //               background: Image.network(
  //                 "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
  //                 fit: BoxFit.cover,
  //               )),

  //         ),

  //       ];
  //     },
  //     body: Center(
  //       child: Text("Sample text"),
  //     ),
  //   ),
  // ),

  // body: ListView.builder(
  //   itemCount: list.length,
  //   itemBuilder: (context, index) {
  //     return TextButton(
  //       child: Text(
  //         '${entries[index]}',
  //         style: TextStyle(fontSize: 25),
  //       ),
  //       style: TextButton.styleFrom(
  //           backgroundColor: Color(0),
  //           padding: EdgeInsets.all(10),
  //           side: BorderSide(color: Color.fromARGB(119, 129, 129, 129)),
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap),
  //       onPressed: () {
  //         //print('Button pressed' + pushanswer.toString() );
  //       },
  //     );

  //   },
  // ),

  // ListView(
  //   children: [
  //     TextButton(
  //       child: Text(
  //         pushanswer.toString(),
  //         style: TextStyle(fontSize: 25),
  //       ),
  //       style: TextButton.styleFrom(
  //           backgroundColor: Color(0),
  //           padding: EdgeInsets.all(10),
  //           side: BorderSide(color: Color.fromARGB(119, 129, 129, 129)),
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap),
  //       onPressed: () {
  //         print('Button pressed' + pushanswer.toString() );
  //       },
  //     ),

  //   ],

  // children: [
  //   ElevatedButton(
  //     onPressed: (){},
  //     child: Text('A'),
  //     style: ElevatedButton.styleFrom(
  //       padding: EdgeInsets.all(0),
  //     ),

  //   ), // ListTile
  //   ElevatedButton(
  //     onPressed: (){},
  //     child: Text('A'),
  //     style: ElevatedButton.styleFrom(
  //       padding: EdgeInsets.all(0),
  //     ),
  //   ),
  //   ElevatedButton(
  //     onPressed: (){},
  //     child: Text('A'),
  //     style: ElevatedButton.styleFrom(
  //       padding: EdgeInsets.all(0),
  //     ),
  //   ),
  //   ]// ListTile
  //),

  // TextButton(
  //   child: Text(
  //     '',
  //     style: TextStyle(fontSize: 25),
  //   ),
  //   style: TextButton.styleFrom(
  //       backgroundColor: Colors.red,
  //       padding: EdgeInsets.all(0),
  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap),
  //   onPressed: () {
  //     print('Button pressed');
  //   },
  // ),
  // TextButton(
  //   child: SizedBox(),
  //   style: TextButton.styleFrom(
  //       backgroundColor: Color.fromARGB(255, 57, 244, 54),
  //       padding: EdgeInsets.all(0),
  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap),
  //   onPressed: () {
  //     print('Button pressed');
  //   },
  // ),

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
