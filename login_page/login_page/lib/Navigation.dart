import 'package:flutter/material.dart';
import 'package:login_page/Screens/Customer/customer_profile.dart';
import 'package:login_page/Screens/Customer/my_requets.dart';
import 'package:login_page/Screens/faq.dart';
import 'package:login_page/Screens/Customer/home_page.dart';

class MyBottomNavigationBar extends StatefulWidget {

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {

  int _currentIndex=0;
  final List<Widget>_children=[HomePage(),MyRequests(),FAQPage(),ProfilePage()];

  void OnTappedBar(int index){
    setState(() {
      _currentIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:_children[_currentIndex],
      bottomNavigationBar:  BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orangeAccent,
        backgroundColor: Color(0xFF0e233f),
        unselectedItemColor: Colors.white,
        onTap: OnTappedBar,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'My Requests',
          ),
          //
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'FAQ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}



/*
class MyBottomNavigationBar extends StatefulWidget {

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  //for the bottom navigation bar
  final List<Widget> _children=[HomePage(),MyRequests(),FAQPage(),ProfilePage()];
  int _currentIndex=1;
  void OnTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orangeAccent,
        backgroundColor: Color(0xFF0e233f),
        unselectedItemColor: Colors.white,
        onTap: OnTappedBar,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'My Requests',
          ),
          //
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'FAQ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Profile',
          ),
        ],
      ),
    );


  }
}*/