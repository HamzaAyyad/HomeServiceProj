import 'package:flutter/material.dart';
import 'package:login_page/Screens/worker_profile.dart';
import 'package:login_page/Screens/home_page_worker.dart';
import 'package:login_page/Screens/faq.dart';


class WorkerBottomNavigationBar extends StatefulWidget {

  @override
  _WorkerBottomNavigationBarState createState() => _WorkerBottomNavigationBarState();
}

class _WorkerBottomNavigationBarState extends State<WorkerBottomNavigationBar> {

  int _currentIndex=0;
  final List<Widget>_children=[HomePageWorker(),FAQPage(),ProfilePageWorker()];

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
            icon: Icon(Icons.collections),
            label: 'Requests',
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


