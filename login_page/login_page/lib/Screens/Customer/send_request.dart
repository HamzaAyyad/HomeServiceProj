//import 'dart:html';

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:login_page/CreateText.dart';
import 'package:login_page/HelpWidget/FirebaseApi.dart';
import 'package:login_page/Screens/pending_request_worker.dart';
import 'package:login_page/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:firebase/firebase.dart';
import 'package:location/location.dart';
import 'package:login_page/HelpWidget/Services.dart';

import 'feedback.dart';

final _firebaseuser = FirebaseFirestore.instance;

bool isDisabled = false;

String problemImageDestination;
String problemImageURL;
String description;
String address;
Location location;
double lat;
double lon;

class SendRequest extends StatefulWidget {
  final String workerEmail;

  SendRequest({this.workerEmail});

  @override
  _SendRequestState createState() => _SendRequestState();
}

class _SendRequestState extends State<SendRequest> {
  final _formKey = GlobalKey<FormState>();

  File file;
  UploadTask task;

  final TextStyle lblStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.black87,
  );
  final TextStyle hintstyle = TextStyle(
    fontSize: 18.0,
    color: Colors.black12,
  );

  Future<String> email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Request'),
        backgroundColor: kDarkBlue,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 7,
              ),
              //Image.asset('images/blueLogo.png', height: 150, width: 150,),
              SizedBox(
                height: 20,
              ),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  maxLines: 5,
                  //controller: control,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kDarkBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide(width: 1, color: kDarkBlue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: lblStyle,
                    icon: Icon(Icons.text_snippet_outlined),
                    hintText: 'What is the problem?',
                    hintStyle: hintstyle,
                  ),
                  // keyboardType: keyboard,
                  //
                  onChanged: (value) {
                    description = value;
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Text(
                'Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              Container(
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text.';
                    }
                    return null;
                  },
                  maxLines: 2,
                  //controller: control,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kDarkBlue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                      borderSide: BorderSide(width: 1, color: kDarkBlue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: lblStyle,
                    icon: Icon(Icons.add_location_alt),
                    hintText: 'Write your address: (Tabarbour,Amman)',
                    hintStyle: hintstyle,
                  ),
                  // keyboardType: keyboard,
                  //
                  onChanged: (value) {
                    address = value;
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Text(
                'Picture of the problem',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              TextButton(
                onPressed: selectFile,
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                  color: kLightBlue,
                ),
              ),

              SizedBox(
                height: 20,
              ),

              RaisedButton(
                color: kDarkBlue,
                child: Text(
                  'Send request to worker',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: isDisabled
                    ? null
                    : () async {
                        if (_formKey.currentState.validate()) {
                          print('i will send a request now');
                          await sendRequest(widget.workerEmail);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Requset Sent')));
                          Navigator.pop(context);
                        }
                      },
              ),
              RaisedButton(
                color: kDarkBlue,
                child: Text(
                  'Worker Feedback',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () async {
                  print('i will send a request now');

                  //await sendRequest(widget.workerEmail);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Requset Sent')));
                  //Navigator.pop(context);
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Feedback(workerEmail: widget.workerEmail)));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WorkerFeedback(WorkerEmail: widget.workerEmail)),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    setState(() {
      isDisabled = true;
    });
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() {
      file = File(path);
      isDisabled = false;
    });
    await uploadFile();
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = file.path;
    final destination = 'images/$fileName';
    setState(() {
      problemImageDestination = destination;
    });

    task = FirebaseApi.uploadFile(destination, file);

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link $urlDownload');
    problemImageURL = urlDownload;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Image Uploaded Succesfully!')));
    setState(() {
      isDisabled = false;
    });
  }
}

Future<User> getCurrentUser() async {
  var auth = FirebaseAuth.instance;
  final User user = auth.currentUser;

  if (user == null) {
    print('Error');
  }
  return user;
}

void sendRequest(String workerEmail) async {
  User user = await getCurrentUser();
  String email = user.email;
  LocationData data = await getLocation();
  String imageURL;
  String fullName;
  String mobileNumber;

  //get the location
  if (data == null) {
    print('location gives null');
    lat = lon = 0;
  } else {
    lat = data.latitude;
    lon = data.longitude;
  }

  String workerName;
  String workerphone;
  String workerImageUrl;

  //get the imageURL by email -> id -> document -> 'imageURL'
  String id;
  var collection = FirebaseFirestore.instance.collection('User');
  await collection.where('email', isEqualTo: workerEmail).get().then(
        (QuerySnapshot snapshot) async => {
          snapshot.docs.forEach((f) async {
            print("documentID---- " + f.reference.id);
            id = f.reference.id;
            var docSnapshot = await collection.doc(id).get();

            Map<String, dynamic> data = docSnapshot.data();
            workerName =
                data['full_name']; // <-- The value you want to retrieve
            workerphone = data['mobile_number'].toString();
            workerImageUrl = data['imageURL'].toString();
            print(workerName);
            print(workerphone);
            print(workerImageUrl);

            if (docSnapshot.exists) {}
          }),
        },
      );
  await collection.where('email', isEqualTo: email).get().then(
        (QuerySnapshot snapshot) async => {
          snapshot.docs.forEach((f) async {
            print("documentID---- " + f.reference.id);
            id = f.reference.id;
            var docSnapshot = await collection.doc(id).get();
            if (docSnapshot.exists) {
              Map<String, dynamic> data = docSnapshot.data();
              imageURL =
                  data['imageURL']; // <-- The value you want to retrieve.
              fullName = data['full_name'];
              mobileNumber = data['mobile_number'].toString();
              print(imageURL);
              print('problem $problemImageURL');
              _firebaseuser.collection('Request').doc().set({
                'customer_email': email,
                'description': description,
                'worker_email': workerEmail,
                'address': address,
                'customer_imageURL': imageURL,
                'location': new GeoPoint(lat, lon),
                'rating': 0,
                'feedback': 'good worker',
                'customer_name': fullName,
                'problem_image': problemImageURL,
                'mobile_number': mobileNumber,
                'worker_name': workerName,
                'status': 0,
                'worker_phone': workerphone,
                'worker_ImageURL': workerImageUrl,
                'isRated': false,
              });
            }
          }),
        },
      );
}
