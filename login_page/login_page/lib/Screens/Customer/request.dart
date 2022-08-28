import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_page/HelpWidget/Request.dart';
import 'package:login_page/HelpWidget/CustomerRequestInfo.dart';
import 'package:login_page/constants.dart';
class RequestPage  extends StatefulWidget {

  final String id;
  RequestPage({this.id});

  @override
  _RequestPageState  createState() => _RequestPageState ();
}

class _RequestPageState  extends State<RequestPage > {

  // Request request = Request(customerImage:'https://firebasestorage.googleapis.com/v0/b/home-services-283bc.appspot.com/o/images%2FUsers%2Fmohammadnassar%2FLibrary%2FDeveloper%2FCoreSimulator%2FDevices%2F82E35996-AB79-45C7-AF14-86024F407A99%2Fdata%2FContainers%2FData%2FApplication%2F4A9AC857-E5C5-4A25-A18C-E6FFEA298EA3%2Ftmp%2Fcom.mhmdnsar.loginPage-Inbox%2FprofilePic.png?alt=media&token=5601c0ca-05f0-47c3-bf09-6336be5ecc54',problemImageURL: '',description: '',phoneNumber: '',address: '',customerName: '' );

  CustomerRequestInfo requestInfo=CustomerRequestInfo(wokerImage:'https://firebasestorage.googleapis.com/v0/b/home-services-283bc.appspot.com/o/images%2FUsers%2Fmohammadnassar%2FLibrary%2FDeveloper%2FCoreSimulator%2FDevices%2F82E35996-AB79-45C7-AF14-86024F407A99%2Fdata%2FContainers%2FData%2FApplication%2F4A9AC857-E5C5-4A25-A18C-E6FFEA298EA3%2Ftmp%2Fcom.mhmdnsar.loginPage-Inbox%2FprofilePic.png?alt=media&token=5601c0ca-05f0-47c3-bf09-6336be5ecc54',problemImageURL: '',description: '',phoneNumber: '',workerName: '' );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('====');
    getRequest(widget.id);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      //drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('Request Information'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,10,0,0),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(requestInfo.wokerImage),
                  ),
                  Text(
                    requestInfo.workerName,
                    style: TextStyle(
                      //fontFamily: 'Pacifico',
                      fontSize: 40.0,
                      color: Color(0xeeffffff),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   request.address,
                  //   style: TextStyle(
                  //     fontFamily: 'Source Sans Pro',
                  //     color: kLightBlue,
                  //     fontSize: 20.0,
                  //     letterSpacing: 2.5,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20.0,
                    width: 150.0,
                    child: Divider(
                      color: Colors.teal.shade100,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      buildCard(title: requestInfo.phoneNumber, icon: Icons.phone),
                      // buildCard(
                      //     title: 'Go to location',
                      //     icon: Icons.directions,
                      //     trailingIcon: Icons.arrow_forward_ios),
                      getImageDescription(),
                      getDescription(),

                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // getButton(text: 'Accept', color: Colors.green),
                            SizedBox(width: 5),
                            // getButton(text: 'Reject', color: Colors.red),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget buildCard({IconData icon, String title, IconData trailingIcon}) {
    var trailingColor = Colors.white;
    if (trailingIcon == null) {
      trailingColor = Colors.white;
      trailingIcon = Icons.arrow_forward_ios;
    }
    return Card(
        color: kDarkBlue,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          trailing: Icon(
            trailingIcon,
            color: trailingColor,
          ),
          title: Text(
            title,
            style: TextStyle(
                fontSize: 20.0,
                color: Color(0xeeffffff),
                fontFamily: 'Source Sans Pro'),
          ),
        ));
  }

  Widget getRating() {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Text('Rating:',
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
      color: kDarkBlue,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Picture of the problem',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xeeffffff),
              ),
            ),
            SizedBox(height: 20),
            Image.network(requestInfo.problemImageURL),
          ],
        ),
      ),
    );
  }

  Widget getDescription() {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      color: kDarkBlue,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Description of the problem',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: Color(0xeeffffff),
              ),
            ),
            SizedBox(height: 20),
            Text(
              requestInfo.description,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xeeffffff),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getButton({Color color, String text}) {
    var alertTitle = 'You Rejected The Request!';
    var alertContent =
        'This request will be deleted and the customer will be notified. Are you sure?';
    if (text == 'Accept') {
      alertTitle = 'You Accepted The Request!';
      alertContent =
      'The request will be accepted and the customer will be notified, you should complete the order. Are you sure?';
    }
    return GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text(alertTitle),
            content: Text(alertContent),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if(text == 'Accept'){
                    acceptRequest();
                    Navigator.pop(context);
                  }
                  else
                    rejectRequest();
                } ,
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      child: Container(
          width: 150,
          height: 50,
          color: color,
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )),
    );
  }

  void acceptRequest() async {
    //widget.id
    var collection = FirebaseFirestore.instance.collection('Request');
    String id = widget.id;
    await collection
        .doc(id)
        .update({
      'status': 1
    });
    print('done');
    Navigator.pop(context, 'OK');
  }

  void rejectRequest() async {
    //widget.id
    var collection = FirebaseFirestore.instance.collection('Request');
    String id = widget.id;
    await collection
        .doc(id)
        .update({
      'status': -1
    });
    Navigator.pop(context, 'Ok');
  }

  void getRequest(String id) async {


    var collection = FirebaseFirestore.instance.collection('Request');
    var docSnapshot = await collection.doc('$id').get();
    if (docSnapshot.exists) {
      Map<String, dynamic> data = docSnapshot.data();
      var value = data['customer_name']; // <-- The value you want to retrieve.
      print(value);
      //print('requ add ${request.address}');

      // Call setState if needed.


      setState(() {

        requestInfo = CustomerRequestInfo(problemImageURL: data['problem_image'],description: data['description'],workerName: data['worker_name'],phoneNumber: data['worker_phone'].toString(),wokerImage:  data['worker_ImageURL']);
        print(requestInfo.workerName);

        // request.problemImageURL = data['problem_image'];
        // request.description = data['description'];
        // request.phoneNumber = data['mobile_number'];
        // request.customerImage = data['customer_imageURL'];
        // request.customerName = data['customer_name'];
        // request.address = data['address'];
      });


    }



  }

}

// Widget buildItemRequest({String name, String specialization, Image image,VoidCallback onClicked}){
//
//   return InkWell(
//     onTap: onClicked,
//     child: Container(
//       padding: EdgeInsets.all(20),
//       child: Row(
//         children: [
//           CircleAvatar(radius: 30,backgroundImage: AssetImage('images/profilePic.png'),),
//           SizedBox(width: 20,),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name,style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Helvetica'),),
//               SizedBox(height: 4,),
//               Text(specialization,style: TextStyle(fontSize: 15, color: Colors.white),),
//             ],
//           ),
//           Spacer(),
//           Icon(Icons.arrow_forward_ios , color: Colors.white,)
//         ],
//       ),
//     ),
//   );
// }
