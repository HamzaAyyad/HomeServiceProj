import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:login_page/HelpWidget/NavigationDrawerWorker.dart';
import 'package:login_page/HelpWidget/Services.dart';
import 'package:login_page/HelpWidget/account.dart';
import 'package:login_page/constants.dart';
import 'package:login_page/HelpWidget/CreateText.dart';
import 'dart:io';
import 'package:login_page/HelpWidget/FirebaseApi.dart';

var collection = FirebaseFirestore.instance.collection('User');

class ProfilePageWorker extends StatefulWidget {
  @override
  _ProfilePageWorkerState createState() => _ProfilePageWorkerState();
}

class _ProfilePageWorkerState extends State<ProfilePageWorker> {
  var image = Image.asset(
    'images/profilePic.png',
    height: 100,
    width: 100,
  );
  var name = 'Adam Abdallah';
  String spec = 'Plumber';
  String email = 'jack@email.com';
  final number = '+962 787147786';
  final _auth = FirebaseAuth.instance;
  bool isDisabled = false;
  int new_mobile_number;
  var new_imageURL;
  File file;
  String imageDestination;
  UploadTask task;
  User loggedInUser;

  WorkerAccount account = WorkerAccount(
      email: '-', name: '-', mobile_number: '0', rating: 0, spec: '-');

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
                print(value.data()['full_name']);
                print(value.data()['email']);
                print(value.data()['rating']);

                setState(() {
                  account.email = value.data()['email'];
                  account.name = value.data()['full_name'];
                  account.rating = double.parse(value.data()['rating'].toString());
                  //= double.parse(value.data()['rating'].toString());
                  account.mobile_number =
                      value.data()['mobile_number'].toString();
                  account.spec = value.data()['specialization'];
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
    getWorkerImage() {
      return new StreamBuilder(
          stream: collection.where('email', isEqualTo: email).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var userDocument = snapshot.data;
            return new Image.network(
              (snapshot.data as dynamic).docs[0]['imageURL'],
              height: 130,
              width: 130,
            );
          });
    }

    return Scaffold(
      backgroundColor: kLightBlueBackground,
      //drawer: NavigationDrawerWoker(),
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
            SizedBox(height: 30,),
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
                              child: getWorkerImage(),
                            ),
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
                                buildCard(
                                    title: account.name,
                                    icon: Icons.drive_file_rename_outline),
                                buildCard(
                                    title: account.spec,
                                    icon: Icons.work_outline_sharp),
                                buildCard(
                                    title: account.email, icon: Icons.email),
                                buildCard(
                                    title: '0' + account.mobile_number,

                                    icon: Icons.phone),
                                getRating(account.rating),
                                TextButton(
                                  onPressed: (){
                                    updateLocation();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Your location was updated!')));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.orange,
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Text(
                                          'Change your location.',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) => EditProfile()),
                                    // );.
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Padding(
                                          padding: EdgeInsets.only(top: 100),
                                          child: ListView(

                                            children: [
                                              AlertDialog(
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
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: CircleAvatar(
                                                          child: Icon(Icons.close),
                                                          backgroundColor:
                                                          Colors.red,
                                                        ),
                                                      ),
                                                    ),
                                                    Form(
                                                      // key: _formKey,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                            end: Alignment.topRight,
                                                            begin: Alignment
                                                                .bottomLeft,
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
                                                              EdgeInsets.all(
                                                                  8.0),
                                                              child:
                                                              RawMaterialButton(
                                                                elevation: 0.0,
                                                                child: Icon(Icons
                                                                    .add_a_photo),
                                                                onPressed: () {
                                                                  selectFile();
                                                                },
                                                                constraints:
                                                                BoxConstraints
                                                                    .tightFor(
                                                                  width: 75.0,
                                                                  height: 75.0,
                                                                ),
                                                                shape:
                                                                CircleBorder(),
                                                                fillColor:
                                                                kLightBlue,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsets.all(
                                                                  8.0),
                                                              child: CreateText(
                                                                hinttxt:
                                                                'Enter Your Mobile No',
                                                                ico: Icon(
                                                                  Icons.phone,
                                                                  color: kDarkBlue,
                                                                ),
                                                                keyboard:
                                                                TextInputType
                                                                    .phone,
                                                                lbltxt: 'Mobile No',
                                                                onChanged: (value) {
                                                                  new_mobile_number =
                                                                      int.parse(
                                                                          value);
                                                                },
                                                                type: 'mobile',
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Edit your information.',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(context, '/home');
                              },
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                        );
                      else
                        return CircularProgressIndicator();
                    })),
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

  void updateLocation() async {
    //get the current worker's email
    User user = (await getCurrentUser()) as User;
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
        }),
      },
    );

    //FirebaseFirestore.instance.collection('collection_name').doc('document_id').update({'field_name': 'Some new data'});
  }

  void UpdateInformation() async {
    if(new_imageURL==null)
    {
      new_imageURL=Image.asset('images/profilePic.png');
      //new_imageURL=account
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
    print('new image $new_imageURL');
    print('new number $new_mobile_number');
    print('done');

    collection = FirebaseFirestore.instance.collection('Request');
    await collection
        .where('worker_email', isEqualTo: email)
        .get()
        .then((QuerySnapshot snapshot) async => {
      snapshot.docs.forEach((f) async {
        id = f.reference.id;
        print(id);
        print('djkkjdfkjhdf');
        collection
            .doc(id)
            .update({
          'worker_ImageURL': new_imageURL,
          'worker_phone' : new_mobile_number,
        });
      })
    });

    Navigator.pop(context, 'OK');
  }

  Widget getRating(double rating) {
    return Card(
        color: kDarkBlue,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Text('Rating:',
              style: TextStyle(
                color: Color(0xeeffffff),
                fontSize: 20,
              )),
          title: Row(children: getStarsIcon(rating)),
        ));
  }

  List<Widget> getStarsIcon(double rating) {
    List<Widget> stars = [];
    for (int i = 0; i < rating - 0.5; i++) {
      stars.add(
        Icon(
          Icons.star,
          color: kStarColor,
          size: 40,
        ),
      );
    }
    if(rating % 1 != 0)
      stars.add(
        Icon(
          Icons.star_half,
          color: kStarColor,
          size: 40,
        ),
      );
    for(int i = 0 ; i< 5- rating - 0.5 ; i++)
      stars.add(
        Icon(
          Icons.star_border,
          color: kStarColor,
          size: 40,
        ),
      );

    return stars;
  }
}
