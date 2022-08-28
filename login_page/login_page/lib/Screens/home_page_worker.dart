import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:login_page/HelpWidget/Services.dart';
import 'package:login_page/HelpWidget/NavigationDrawerWorker.dart';
import 'package:login_page/HelpWidget/Location.dart';
import 'package:login_page/Screens/finished_request_worker.dart';
import 'package:login_page/Screens/ongoing_request_worker.dart';
import 'package:login_page/Screens/pending_request_worker.dart';
import '../constants.dart';

class HomePageWorker extends StatefulWidget {
  @override
  _HomePageWorkerState createState() => _HomePageWorkerState();
}

class _HomePageWorkerState extends State<HomePageWorker> {
  double lat;
  double lon;

  final name0 = 'Ahmad Yousef ';
  final location0 = 'tabarbour, Amman';

  final name1 = 'Khaled Saleh ';
  final location1 = 'Arjan, Amman';
  final name2 = 'Zaid Ammar ';
  final location2 = 'Shafa Badran, Amman';
  final name3 = 'Moustafa Mohammad ';
  final location3 = 'Abdoun, Amman';
  final name4 = 'Ziad Khaleel ';
  final location4 = 'Sweileh, Amman';
  String email;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getRequests();

  }

  void getRequests() async {
    final user = await _auth.currentUser;
    if (user != null) {
      setState(() {
        loggedInUser = user;
        email = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(

      // final  Map<String, Object>rcvdData = ModalRoute.of(context).settings.arguments;
      // print("rcvd fdata ${rcvdData['email']}");
      // email = rcvdData['email'];

      length: 3,
      child: Scaffold(
        backgroundColor: Colors.red,
        //drawer: NavigationDrawerWoker(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // actions: <Widget>[
          //   IconButton(
          //       icon: Icon(
          //         Icons.location_on,
          //         color: Colors.deepOrange,
          //       ),
          //       onPressed: updateLocation)
          // ],
          backgroundColor: kDarkBlue,
          title: Text('My Requests'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Pending',
                icon: Icon(Icons.pending_outlined),
              ),
              Tab(
                text: 'Ongoing',
                icon: Icon(Icons.timelapse),
              ),
              Tab(
                text: 'Finished',
                icon: Icon(Icons.check),
              ),
            ],
            labelColor: Colors.orangeAccent,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topRight,
                  begin: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF0e233f),
                    //kDarkBlue,
                    Colors.black,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                //height: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 5),
                      child: Text(
                        'Pending Requests',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xeeffffff),
                          //fontFamily: 'Helvetica',
                        ),
                      ),
                    ),
                    RequestList(
                      email: email,
                      status: 0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topRight,
                  begin: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF0e233f),
                    //kDarkBlue,
                    Colors.black,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                //height: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 5),
                      child: Text(
                        'Ongoing Requests',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xeeffffff),
                          //fontFamily: 'Helvetica',
                        ),
                      ),
                    ),
                    RequestList(
                      email: email,
                      status: 1,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topRight,
                  begin: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF0e233f),
                    //kDarkBlue,
                    Colors.black,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                //height: double.infinity,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 5),
                      child: Text(
                        'Finished Requests',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xeeffffff),
                          //fontFamily: 'Helvetica',
                        ),
                      ),
                    ),
                    RequestList(
                      email: email,
                      status: 2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ));

  Widget buildItemRequest(
      {String name, String location, Image image, VoidCallback onClicked}) {
    return Container(
        color: kLightBlue,
        child: InkWell(
          onTap: onClicked,
          child: Container(
            color: kLightBlue,
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
                          color: kLightBlue,
                          fontFamily: 'Helvetica'),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      location,
                      style: TextStyle(fontSize: 15, color: kLightBlue),
                    ),
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: kLightBlue,
                )
              ],
            ),
          ),
        ));
  }

  void updateLocation() async {
    //get the current worker's email
    User user = await getCurrentUser();
    String email = user.email;
    print(email);

    //get the current location
    LocationData data = await getLocation();

    //get the document holding the worker's data
    var collection = FirebaseFirestore.instance.collection('User');

    //var querySnapshots = await collection.get();
    // for (var snapshot in querySnapshots.docs) {
    //   var documentID = snapshot.id; // <-- Document ID
    //   print(documentID);
    //   collection.doc(documentID).get();
    // }

    //get the id using the email
    String id;
    collection.where('email', isEqualTo: email).get().then(
          (QuerySnapshot snapshot) => {
            snapshot.docs.forEach((f) {
              print("documentID---- " + f.reference.id);
              id = f.reference.id;
              collection.doc(id).update(
                  {'location': new GeoPoint(data.latitude, data.longitude)});
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Your location was updated!')));
            }),
          },
        );

    //FirebaseFirestore.instance.collection('collection_name').doc('document_id').update({'field_name': 'Some new data'});
  }
}

class RequestList extends StatelessWidget {
  const RequestList({this.email, this.status});

  final String email;
  final int status;

  @override
  Widget build(BuildContext context) {
    var collection = FirebaseFirestore.instance.collection('Request');
    print('from requestlist class email is $email');

    //print(email);

    if (email != null)
      return StreamBuilder(
          stream: collection
              .where('worker_email', isEqualTo: email)
              .where('status', isEqualTo: status)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 15),
                    Text('There are no requests...')
                  ],
                ),
              );
            }
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: snapshot.data.docs.map((request) {
                String id = request.id;
                return Padding(
                    padding: EdgeInsets.fromLTRB(10, 7, 10, 0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: kDarkBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        //color: kLightBlue,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    if(status == 0)
                                      return RequestWorker(id: id);
                                    else if(status == 1)
                                      return OngoingRequest(id: id);
                                    else if(status == 2)
                                      return FinishedRequest(id: id);
                                    else return null;
                                  }

                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(
                                      request['customer_imageURL']),
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      request['customer_name'],
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.white,
                                          fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      request['address'],
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white),
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
                        )));
              }).toList(),
            );
          });
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline),
          SizedBox(width: 15),
          Text('There are no requests...')
        ],
      ),
    );

    //
    //
    // return Container(
    //   height: 300.0,
    //   width: MediaQuery.of(context).size.width,
    //   child: ListView.builder(
    //     scrollDirection: Axis.horizontal,
    //     itemCount: destinations.length,
    //     itemBuilder: (BuildContext context, int index){
    //       Destination destination = destinations[index];
    //       return InkWell(
    //         onTap: (){
    //
    //         },
    //         child: Container(
    //           padding: EdgeInsets.all(20),
    //           child: Row(
    //             children: [
    //               CircleAvatar(radius: 30,backgroundImage: AssetImage('images/profilePic.png'),),
    //               SizedBox(width: 20,),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(name,style: TextStyle(fontSize: 17, color: Colors.white, fontFamily: 'Helvetica'),),
    //                   SizedBox(height: 4,),
    //                   Text(location,style: TextStyle(fontSize: 15, color: Colors.white),),
    //                 ],
    //               ),
    //               Spacer(),
    //               Icon(Icons.arrow_forward_ios , color: Colors.white,)
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
