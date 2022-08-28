import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:login_page/HelpWidget/FirebaseApi.dart';
import 'package:login_page/HelpWidget/NavigationDrawer.dart';
import 'package:login_page/HelpWidget/account.dart';
import 'package:login_page/constants.dart';
import 'package:login_page/HelpWidget/CreateText.dart';
import 'edit_profile.dart';

var collection = FirebaseFirestore.instance.collection('User');

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File file;
  String imageDestination;
  UploadTask task;
  String imageURL;
  bool isDisabled = false;
  int new_mobile_number;
  var new_imageURL;
  final _text = TextEditingController();

  var image = Image.asset(
    'images/profilePic.png',
    height: 100,
    width: 100,
  );
  var name = 'Adam Abdallah';
  String email = 'jack@email.com';
  final number = '+962 787147786';
  final _auth = FirebaseAuth.instance;
  User loggedInUser;

  Account account =
      Account(email: '-', name: '-', mobile_number: '0', rating: 0);

  @override
  void initState() {
    // TODO: implement initState

    print(account.name);
    super.initState();

    getCurrentUser();
  }

  String id;

  Future<String> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        email = user.email;

        collection.where('email', isEqualTo: email).get().then(
              (QuerySnapshot snapshot) => {
                snapshot.docs.forEach((f) {
                  print("documentID---- " + f.reference.id);
                  id = f.reference.id;
                  collection.doc(id).get().then((value) {
                    print(value.data()['full_name']);
                    print('from profile page');
                    print(value.data()['imageURL']);

                    setState(() {
                      account.email = value.data()['email'];
                      account.name = value.data()['full_name'];
                      //account.rating = value.data()['rating'];
                      //account.rating = double.parse(value.data()['rating'].toString());
                      account.mobile_number =
                          value.data()['mobile_number'].toString();

                      image = Image.network(
                        value.data()['imageURL'],
                        height: 130,
                        width: 130,
                      );
                    });
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

  @override
  Widget build(BuildContext context) {
    getCustomerImage() {
      return new StreamBuilder(
          stream: collection.where('email', isEqualTo: email).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            return new Image.network(
              (snapshot.data as dynamic).docs[0]['imageURL'],
              height: 130,
              width: 130,
            );
          });
    }

    return Scaffold(
      backgroundColor: kLightBlueBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kDarkBlue,
        title: Text('Profile'),
      ),
      body: Container(
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
        child: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     end: Alignment.topRight,
              //     begin: Alignment.bottomLeft,
              //     colors: [
              //       Color(0xFF0e233f),
              //       //kDarkBlue,
              //
              //       Colors.black,
              //     ],
              //   ),
              // ),
              child: StreamBuilder<Object>(
                  stream:
                      collection.where('email', isEqualTo: email).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: getCustomerImage(),
                          ),
                          SizedBox(
                            height: 20.0,
                            width: 150.0,
                            child: Divider(
                              color: Colors.teal.shade100,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildCard(
                                  title: account.name,
                                  icon: Icons.drive_file_rename_outline),
                              buildCard(
                                  title: account.email, icon: Icons.email),
                              buildCard(
                                  title: '0' + account.mobile_number,
                                  //'0' + (snapshot.data as dynamic)
                                  //                                       .docs[0]['mobile_number']
                                  //                                       .toString() == null ? '-' :
                                  icon: Icons.phone),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.black,
                                        elevation: 8.0,
                                        content: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Positioned(
                                              right: -40.0,
                                              top: -40.0,
                                              child: InkResponse(
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: CircleAvatar(
                                                  child: Icon(Icons.close),
                                                  backgroundColor: Colors.red,
                                                ),
                                              ),
                                            ),
                                            Form(
                                              // key: _formKey,
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
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: RawMaterialButton(
                                                        elevation: 0.0,
                                                        child: Icon(
                                                            Icons.add_a_photo),
                                                        onPressed: () {
                                                          selectFile();
                                                        },
                                                        constraints:
                                                            BoxConstraints
                                                                .tightFor(
                                                          width: 75.0,
                                                          height: 75.0,
                                                        ),
                                                        shape: CircleBorder(),
                                                        fillColor: kLightBlue,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: CreateText(
                                                        hinttxt:
                                                            'Enter Your Mobile No',
                                                        ico: Icon(
                                                          Icons.phone,
                                                          color: kDarkBlue,
                                                        ),
                                                        keyboard:
                                                            TextInputType.phone,
                                                        lbltxt: 'Mobile No',
                                                        onChanged: (value) {
                                                          new_mobile_number =
                                                              int.parse(value);
                                                        },
                                                        type: 'mobile',
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ElevatedButton(
                                                        child: Text(
                                                          '   Save   ',
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        style: ButtonStyle(
                                                          shape: MaterialStateProperty.all<
                                                                  RoundedRectangleBorder>(
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.0),
                                                          )),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      kDarkBlue),
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            UpdateInformation();
                                                          });
                                                        },

                                                        // if (_formKey.currentState.validate()) {
                                                        //   _formKey.currentState.save();
                                                        //,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                    'Edit your information.',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/home');
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Text(
                                    'Log Out!',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    else
                      return CircularProgressIndicator();
                  }),
            ),
          ],
        ),
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

  Future selectFile() async {
    setState(() {
      isDisabled = true;
    });
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() {
      file = File(path);
    });
    await uploadFile();
  }

  Future uploadFile() async {
    if (file == null) return;

    final fileName = file.path;
    final destination = 'images/$fileName';
    setState(() {
      imageDestination = destination;
    });

    task = FirebaseApi.uploadFile(destination, file);

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link $urlDownload');
    new_imageURL = urlDownload;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Image Uploaded Succesfully!')));
    setState(() {
      isDisabled = false;
    });
  }

  void UpdateInformation() async {

    if(new_imageURL==null)
      {
        new_imageURL=Image.asset('images/profilePic.png');
      }
    if(new_mobile_number==null)
      {
        new_mobile_number=int.parse(account.mobile_number);
      }
    //widget.id
    var collection = FirebaseFirestore.instance.collection('User');
    // id = widget.id;
    await collection
        .doc(id)
        .update({'imageURL': new_imageURL, 'mobile_number': new_mobile_number});
    print('done');
    print('new image $new_imageURL');
    print('new number $new_mobile_number');

    //my type = 0
    collection = FirebaseFirestore.instance.collection('Request');
    await collection
        .where('customer_email', isEqualTo: email)
        .get()
        .then((QuerySnapshot snapshot) async => {
              snapshot.docs.forEach((f) async {
                id = f.reference.id;
                print(id);
                print('djkkjdfkjhdf');
                collection
                .doc(id)
                .update({
                  'customer_imageURL': new_imageURL,
                  'mobile_number' : new_mobile_number,
                });
              })
            });

    Navigator.pop(context, 'OK');
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
