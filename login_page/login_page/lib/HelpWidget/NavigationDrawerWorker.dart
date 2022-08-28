import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_page/constants.dart';

class NavigationDrawerWoker extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final name = 'First LastName';
  final email = 'jack@email.com';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: Material(
        color: Color(0xffA8DADC),
        child: ListView(
          // Important: Remove any padding from the ListView.
          //padding: padding,
          children: <Widget>[
            Container(
              color: kLightBlue,
              child: buildHeader(
                  name: name,
                  email: email,
                  onClicked: () => selectedItem(context, 0)),
            ),
            buildMenuItem(
                icon: Icons.person,
                title: 'Profile',
                onClicked: () => selectedItem(context, 0)),
            buildMenuItem(
                icon: Icons.list,
                title: 'Requested Order',
                onClicked: () => selectedItem(context, 1)),
            buildMenuItem(
                icon: Icons.check_box,
                title: 'Finished Request',
                onClicked: () => selectedItem(context, 2)),
            buildMenuItem(
                icon: Icons.phone,
                title: 'Contact Us',
                onClicked: () => selectedItem(context, 3)),
            buildMenuItem(
                icon: Icons.info_outline,
                title: 'FAQ',
                onClicked: () => selectedItem(context, 4)),
            buildMenuItem(
                icon: Icons.person,
                title: 'Log out',
                onClicked: () => selectedItem(context, 5)),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(
      {IconData icon, String title, VoidCallback onClicked, String name}) {
    return ListTile(
      leading: Icon(
        icon,
        color: kDarkBlue,
      ),
      title: Text(title, style: TextStyle(color: kDarkBlue, fontSize: 18)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/worker_profile');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/homeworker');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/finished_request');
        break;
      case 3:
        Navigator.pushNamed(context, '/contact');
        break;
      case 4:
        Navigator.pushNamed(context, '/faq');
        break;
      case 5:
        Navigator.pushReplacementNamed(context, '/home');
        break;
    }
  }

  Widget buildHeader(
      {String name, String email, Image image, VoidCallback onClicked}) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('images/profilePic.png'),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Helvetica'),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
