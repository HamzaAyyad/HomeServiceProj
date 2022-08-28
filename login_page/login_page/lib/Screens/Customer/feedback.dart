import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_page/HelpWidget/Request.dart';
import 'package:login_page/HelpWidget/CustomerRequestInfo.dart';
import 'package:login_page/constants.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class WorkerFeedback extends StatefulWidget {
  final String WorkerEmail;
  WorkerFeedback({this.WorkerEmail});
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<WorkerFeedback> {
  //CustomerRequestInfo requestInfo=CustomerRequestInfo(wokerImage:'https://firebasestorage.googleapis.com/v0/b/home-services-283bc.appspot.com/o/images%2FUsers%2Fmohammadnassar%2FLibrary%2FDeveloper%2FCoreSimulator%2FDevices%2F82E35996-AB79-45C7-AF14-86024F407A99%2Fdata%2FContainers%2FData%2FApplication%2F4A9AC857-E5C5-4A25-A18C-E6FFEA298EA3%2Ftmp%2Fcom.mhmdnsar.loginPage-Inbox%2FprofilePic.png?alt=media&token=5601c0ca-05f0-47c3-bf09-6336be5ecc54',problemImageURL: '',description: '',phoneNumber: '',workerName: '' );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('====');
    //getRequest(widget.WorkerEmail);


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('Worker Feedback'),
      ),
      body: Container(
        height: double.infinity,
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

        child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              getfeedback(widget.WorkerEmail),
            ],
          ),
        ),


      ),
    );
  }

  Widget getfeedback(String email)
  {
    var collection = FirebaseFirestore.instance.collection('Request');
    print('from requestlist class email is $email');

    //print(email);

    if (email != null)
      return StreamBuilder(
          stream: collection
              .where('worker_email', isEqualTo: email)
              .where('status', isEqualTo: 2 )
              .where('isRated' ,isEqualTo: true )
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline),
                    SizedBox(width: 15),
                    Text('There are no feedback...')
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

                                Row(children: getStarsIcon(double.parse(request['rating'].toString()))),
                                Text(

                                  request['feedback'],
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ],
                            ),
                            Spacer(),

                          ],
                        ),
                      ),
                    ));
              }).toList(),
            );
          });
    else
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline),
            SizedBox(width: 15),
            Text('There are no feedback...')
          ],
        ),
      );
  }
  List<Widget> getStarsIcon(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < rating - 0.5; i++) {
      stars.add(
        Icon(
          Icons.star,
          color: kStarColor,
          size: 20,
        ),
      );
    }
    if(rating % 1 != 0)
      stars.add(
        Icon(
          Icons.star_half,
          color: kStarColor,
          size: 20,
        ),
      );
    for(int i = 0 ; i< 5- rating - 0.5 ; i++)
      stars.add(
        Icon(
          Icons.star_border,
          color: kStarColor,
          size: 20,
        ),
      );

    return stars;
  }

}
