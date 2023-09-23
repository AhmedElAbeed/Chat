import 'package:chat_v2/Screens/HomeScreen.dart';
import 'package:chat_v2/Screens/ProfileScreen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final _bottomNavigationBarItems = [

    BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.redAccent),
      label: 'Home',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person, color: Colors.redAccent),
      label: 'Profile',
    ),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          HomeScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: _bottomNavigationBarItems,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //type: BottomNavigationBarType.fixed,
      ),
    );
  }
}