import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page/Google_Map_Screen/GMAC.dart';
import 'package:login_page/Google_Map_Screen/GMElec.dart';
import 'package:login_page/Google_Map_Screen/GMPainter.dart';
import 'package:login_page/Google_Map_Screen/GMPlumber.dart';
import 'package:login_page/Screens/Customer/google_maps.dart';
import 'package:login_page/Google_Map_Screen/GMgeneral.dart';
import 'package:login_page/HelpWidget/NavigationDrawer.dart';
import 'package:login_page/Screens/Customer/customer_profile.dart';
import 'package:login_page/constants.dart';
import 'package:login_page/model/activity_model.dart';
import 'package:login_page/model/destination_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String email;
  String name;
  String specilization;


  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  Future<String> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;

        var collection = FirebaseFirestore.instance.collection('User');

        String id;
        collection.where('email', isEqualTo: email).get().then(
              (QuerySnapshot snapshot) => {
                snapshot.docs.forEach((f) {
                  print("documentID---- " + f.reference.id);
                  id = f.reference.id;
                  collection.doc(id).get().then((value) {
                    print(value.data()['full_name']);
                    return value.data()['full_name'];
                  });
                }),
              },
            );

        return loggedInUser.email;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, Object> rcvdData =
        ModalRoute.of(context).settings.arguments;
    print("rcvd fdata ${rcvdData['email']}");
    email = rcvdData['email'];
    print('========== $email');

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.topRight,
            begin: Alignment.bottomLeft,
            colors: [
              Color(0xFF0e233f),
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      child: Padding(
                    padding: EdgeInsets.all(7),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'images/homepage2.png',
                        width: double.infinity,
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 15,
                  ),
                  Row(children: <Widget>[
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      height: 3,
                      indent: 5,
                      endIndent: 5,
                      color: Colors.orange,
                    )),
                    Text(
                      "WE PROVIDE THE BEST SERVICES",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      height: 3,
                      endIndent: 5,
                      indent: 5,
                      color: Colors.orange,
                    )),
                  ]),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        CreateImageIcon(
                          img: 'elec',
                          desc: 'Electrician',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'Electrician');
                            }));
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CreateImageIcon(
                          img: 'plum',
                          desc: 'Plumber',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'Plumper');
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        CreateImageIcon(
                          img: 'paint',
                          desc: 'Painter',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'Painter');
                            }));
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CreateImageIcon(
                          img: 'tile',
                          desc: 'Tile Worker',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'Tiler');
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        CreateImageIcon(
                          img: 'maint',
                          desc: 'General Maintenance',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'General Maintenance');
                            }));
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CreateImageIcon(
                          img: 'ac',
                          desc: 'AC Maintenance',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'AC Maintenance');
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      children: [
                        CreateImageIcon(
                          img: 'carpenterIcon',
                          desc: 'Carpenter',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'Carpenter');
                            }));
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CreateImageIcon(
                          img: 'satelliteIcon',
                          desc: 'Satellite',
                          onpress: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GoogleMaps(specialization: 'Satellite');
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      //drawer: NavigationDrawer(),
    );
  }
}

class CreateImageIcon extends StatelessWidget {
  final String img;
  final String desc;
  final Function onpress;

  CreateImageIcon({this.img, this.desc, this.onpress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: kDarkBlue,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 100,
          width: 100,
          child: GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/$img.png',
                  height: 69,
                  width: 69,
                ),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xeeffffff),
                  ),
                ),
              ],
            ),
            onTap: onpress,
          ),
        ),
      ),
    );
  }
}
