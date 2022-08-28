import 'package:flutter/material.dart';
import 'package:login_page/HelpWidget/NavigationDrawerWorker.dart';

import '../constants.dart';

class FinishedRequest extends StatelessWidget {
  //final padding = EdgeInsets.symmetric(horizontal: 20);
  final name = 'Anwar Saeed ';
  final location = 'Amman-Swieleh';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWoker(),
      appBar: AppBar(
        backgroundColor: kLightBlue,
        title: Text('Finished Requests'),
      ),
      body: Container(
        color: kLightBlueBackground,
        child: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: kLightBlue,
                      child: buildItemRequest(
                          name: name,
                          loc: location,
                          onClicked: () {
                            Navigator.pushNamed(context, '/finishedinfo');
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: kLightBlue,
                      child: buildItemRequest(
                          name: 'Mohammad Ibrahim',
                          loc: 'Amman-Jubeiha',
                          onClicked: () {
                            Navigator.pushNamed(context, '/finishedinfo');
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: kLightBlue,
                      child: buildItemRequest(
                          name: 'Rafat Yousef',
                          loc: 'Amman-Arjan',
                          onClicked: () {
                            Navigator.pushNamed(context, '/finishedinfo');
                          }),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: kLightBlue,
                      child: buildItemRequest(
                          name: 'Rashed Saif',
                          loc: 'Amman-Marka',
                          onClicked: () {
                            Navigator.pushNamed(context, '/finishedinfo');
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildItemRequest(
      {String name, String loc, Image image, VoidCallback onClicked}) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: EdgeInsets.all(20),
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
                      fontSize: 17,
                      color: Colors.white,
                      fontFamily: 'Helvetica'),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  loc,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ],
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class CreateListTile extends StatelessWidget {
  final String Question;
  final String Answer;
  CreateListTile({this.Question, this.Answer});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        tileColor: kLightBlueBackground,
        //trailing: Icon(Icons.more_vert),
        isThreeLine: true,
        title: Text(Question),
        subtitle: Text(Answer),
      ),
    );
  }
}
