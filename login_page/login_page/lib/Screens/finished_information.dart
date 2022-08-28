import 'package:flutter/material.dart';
import 'package:login_page/HelpWidget/NavigationDrawer.dart';
import 'package:login_page/HelpWidget/NavigationDrawerWorker.dart';
import 'package:login_page/constants.dart';
import 'package:login_page/CreateText.dart';

class FinishedRequestInfo extends StatefulWidget {
  const FinishedRequestInfo({Key key}) : super(key: key);

  @override
  _FinishedRequestInfoState createState() => _FinishedRequestInfoState();
}

class _FinishedRequestInfoState extends State<FinishedRequestInfo> {
  //Map data = {};
  var name;
  final email = 'jack@email.com';
  final number = '+962 70 123 1234';
  var location = 'Tabarbour, Amman';
  final getToLocation = 'Location Of The Customer';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBlueBackground,
      drawer: NavigationDrawerWoker(),
      appBar: AppBar(
        backgroundColor: kLightBlue,
        title: Text('My Request'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
            color: kLightBlueBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('images/profilePic.png'),
                ),
                Text(
                  'Customer\'s Name',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    fontSize: 40.0,
                    color: kDarkBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Customer\'s location',
                  style: TextStyle(
                    fontFamily: 'Source Sans Pro',
                    color: kLightBlue,
                    fontSize: 20.0,
                    letterSpacing: 2.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                  width: 150.0,
                  child: Divider(
                    thickness: 2,
                    color: Colors.teal.shade100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildCard(title: 'Done', icon: Icons.check_box),
                    buildCard(title: '25 JD', icon: Icons.attach_money),
                    buildCard(title: email, icon: Icons.email),
                    buildCard(title: number, icon: Icons.phone),
                    buildCard(
                        title: getToLocation,
                        icon: Icons.directions,
                        trailingIcon: Icons.arrow_forward_ios),
                    getRating(),
                    getImageDescription(),
                    getDescription(),
                    //CreateText(hinttxt: 'Enter Your Price',ico: Icon(Icons.attach_money),lbltxt: 'Price:',keyboard: TextInputType.number,),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  Widget buildCard({IconData icon, String title, IconData trailingIcon}) {
    Color color = kDarkBlue;

    if (title == 'Done') {
      color = Colors.green;
    } else if (title == 'Not Done') {
      color = Colors.red;
    }
    var trailingColor = kDarkBlue;
    if (trailingIcon == null) {
      trailingColor = Colors.white;
      trailingIcon = Icons.arrow_forward_ios;
    }
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: kDarkBlue,
          ),
          trailing: Icon(
            trailingIcon,
            color: trailingColor,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 20.0, color: color, fontFamily: 'Source Sans Pro'),
          ),
        ));
  }

  Widget getRating() {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Text('Your Rating:',
              style: TextStyle(
                color: kDarkBlue,
                fontSize: 20,
              )),
          title: Row(
            children: [
              Icon(
                Icons.star,
                color: kStarColor,
                size: 40,
              ),
              Icon(
                Icons.star,
                color: kStarColor,
                size: 40,
              ),
              Icon(
                Icons.star,
                color: kStarColor,
                size: 40,
              ),
              Icon(
                Icons.star,
                color: kStarColor,
                size: 40,
              ),
            ],
          ),
        ));
  }

  Widget getImageDescription() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Picture of the problem:',
              style: TextStyle(
                fontSize: 25,
                color: kLightBlue,
              ),
            ),
            SizedBox(height: 20),
            Image.asset('images/sink.jpg')
          ],
        ),
      ),
    );
  }

  Widget getDescription() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Description of the problem:',
              style: TextStyle(
                fontSize: 25,
                color: kLightBlue,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'I have a broken sink.. i dont know what to do..its leaking and i need help as soon as possible.',
              style: TextStyle(
                fontSize: 20,
                color: kDarkBlue,
              ),
            )
          ],
        ),
      ),
    );
  }
}
