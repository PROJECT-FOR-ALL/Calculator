import 'voice.dart';
import 'calculate.dart';
import 'history.dart';
import 'package:flutter/material.dart';
import 'package:loop_page_view/loop_page_view.dart';

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
  int page = 0;
  final List screens = [PageVoice(), PageCalculate()];

  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       appBar: AppBar(
  //         bottomOpacity: 0.0,
  //         elevation: 0.0,
  //         title: Text("",
  //             style: TextStyle(fontSize: 25, color: Color(0xFF57636C))),
  //         backgroundColor: Color(0xFFF1F4F8),
  //         iconTheme: IconThemeData(color: Color(0xFF57636C)),
  //         actions: [
  //           IconButton(
  //               onPressed: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => screens[2]));
  //               },
  //               icon: Icon(Icons.history))
  //         ],
  //       ),

  //       body: Center(
  //         child: screens[index],
  //       ),

  //       //   bottomNavigationBar: RoundedTabbarWidget(
  //       //     tabIcons: [
  //       //       Icons.mic,
  //       //       Icons.calculate,
  //       //       Icons.history
  //       //     ],
  //       //     pages: [
  //       //       PageVoice(), PageCalculate(), PageHistory()
  //       //     ],
  //       //     selectedIndex: 0,
  //       //   onTabItemIndexChanged: (int index) {
  //       //       print('Index: $index');
  //       // },
  //       // ),

  //   // bottomNavigationBar: NavigationBarTheme(
  //   //     data: NavigationBarThemeData(
  //   //         indicatorColor: Colors.blue.shade100,
  //   //         labelTextStyle: MaterialStateProperty.all(
  //   //             TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
  //   //     child: NavigationBar(
  //   //         height: 60,
  //   //         backgroundColor: Color(0),
  //   //         labelBehavior:
  //   //             NavigationDestinationLabelBehavior.onlyShowSelected,
  //   //         selectedIndex: index,
  //   //         animationDuration: Duration(seconds: 2),
  //   //         onDestinationSelected: (index) =>
  //   //             setState(() => this.index = index),
  //   //         destinations: [
  //   //           NavigationDestination(icon: Icon(Icons.mic), label: 'Voice'),
  //   //           NavigationDestination(
  //   //               icon: Icon(Icons.calculate), label: 'Calculate'),
  //   //           NavigationDestination(
  //   //               icon: Icon(Icons.history), label: 'History')
  //   //         ])),

  //   //bottomNavigationBar: DefaultTabController();

  //   backgroundColor: const Color(0xFFF1F4F8),
  // );

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   bottomOpacity: 0.0,
        //   elevation: 0.0,
        //   title: const Text("",
        //       style: TextStyle(fontSize: 25, color: Color(0xFF57636C))),
        //   backgroundColor: Color(0xFFF1F4F8),
        //   iconTheme: IconThemeData(color: Color(0xFF57636C)),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           Navigator.push(context,
        //               MaterialPageRoute(builder: (context) => screens[2]));
        //         },
        //         icon: const Icon(Icons.history))
        //   ],
        // ),

        // bottomNavigationBar: NavigationBarTheme(

        //     data: NavigationBarThemeData(

        //         indicatorColor: Colors.blue.shade100,
        //         labelTextStyle: MaterialStateProperty.all(
        //             TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        //     child: NavigationBar(
        //         height: 60,
        //         backgroundColor: Color(0),
        //         labelBehavior:
        //             NavigationDestinationLabelBehavior.onlyShowSelected,
        //         selectedIndex: index,
        //         animationDuration: Duration(seconds: 2),
        //         onDestinationSelected: (index) =>
        //             setState(() => this.index = index),
        //         destinations: [
        //           NavigationDestination(icon: Icon(Icons.mic), label: 'Voice'),
        //           NavigationDestination(icon: Icon(Icons.calculate), label: 'Calculate'),
        //           NavigationDestination(icon: Icon(Icons.history), label: 'History')
        //         ])),

        // body: PageView(
        //   children: [screens[index]],
        //   ),

        // body: PageView.builder(
        //   itemBuilder: (context, _pageController) {
        //     return Container(
        //       color: _pageController % 3 == 0 ? Colors.pink : Colors.cyan,
        //     );
        //   },
        // ),

        // ใช้อันนี้
        body: PageView(
          //loop: false,
          controller: _pageController,
          //pageSnapping: false,
          onPageChanged: (page) {
            setState(() {
              _currentIndex = page;
            });
          },
          children: [
            PageVoice(),
            PageCalculate(),
          ],
        ),

        // body: Center(
        //       child: LoopPageView.builder(
        //         //controller: _pageController,
        //           itemCount: 2,
        //           itemBuilder: (context, _pageController){
        //             return Container(
        //               child: screens[_pageController],
        //             );
        //           }
        //           ),
        // ),

        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Color(0xFFF1F4F8),
          selectedFontSize: 15,
          selectedItemColor: Color(0xFF7BCFFF),
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.shifting,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.mic),
              label: 'Voice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Calculator',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.history),
            //   label: 'History',
            // ),
          ],
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          },
        ),
      );
}
