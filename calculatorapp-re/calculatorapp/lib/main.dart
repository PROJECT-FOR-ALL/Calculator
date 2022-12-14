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

  @override
  Widget build(BuildContext context) => Scaffold(
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
          ],
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          },
        ),
      );
}
