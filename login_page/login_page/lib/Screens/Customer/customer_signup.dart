import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:login_page/HelpWidget/FirebaseApi.dart';
import 'package:login_page/HelpWidget/Services.dart';
import 'package:login_page/constants.dart';
import 'package:login_page/HelpWidget/CreateText.dart';
//import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:login_page/HelpWidget/image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
//import 'package:firebase/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../first_screen.dart';
import 'home_page.dart';

final _firebaseuser = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
bool isDisabled = false;

class CustomerSignup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CustomerSignupState();
  }
}

class _CustomerSignupState extends State<CustomerSignup> {
  UploadTask task;
  File file;


  String email;
  String password;
  String full_name;
  int mobile_number;
  String imageDestination;
  String imageURL;

  File _image;
  //final picker = ImagePicker();
  bool passvis = true;
  bool showSpinner = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? file.path : 'No File Selected!';
    var control = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up as a Customer',
        ),
        backgroundColor: kDarkBlue,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Center(
          child: Container(
            height: double.infinity,
            color: kLightBlueBackground,
            child: SafeArea(
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            child: RoundIconButton(
                              icon: Icons.add_a_photo,
                              onPressed: selectFile,
                            )),
                        CreateText(
                          hinttxt: 'Enter Your Full Name',
                          ico: Icon(
                            Icons.drive_file_rename_outline,
                            color: kDarkBlue,
                          ),
                          keyboard: TextInputType.text,
                          lbltxt: 'Full Name',
                          onChanged: (value) {
                            full_name = value;
                          },
                          type: 'name',
                        ),
                        CreateText(
                          hinttxt: 'Enter Your Mobile No',
                          ico: Icon(
                            Icons.phone,
                            color: kDarkBlue,
                          ),
                          keyboard: TextInputType.phone,
                          lbltxt: 'Mobile No',
                          onChanged: (value) {
                            mobile_number = int.parse(value);
                          },
                          type: 'mobile',
                        ),
                        CreateText(
                            hinttxt: 'Enter Your Email',
                            ico: Icon(
                              Icons.email_rounded,
                              color: kDarkBlue,
                            ),
                            keyboard: TextInputType.emailAddress,
                            lbltxt: 'Email',
                            onChanged: (value) {
                              email = value;
                            },
                          type: 'email',
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: TextFormField(

                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text.';
                              } else if(!validatePassword(value)){
                                return 'Password must be at least 6 letters.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kDarkBlue),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(width: 1, color: kDarkBlue),
                              ),
                              labelText: "Password",
                              labelStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
                              ),
                              hintText: "Enter Your Password",
                              hintStyle: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black12,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passvis ? (Icons.visibility) : Icons.visibility_off,
                                  color: kDarkBlue,
                                ),
                                onPressed: () {
                                  setState(() {
                                    passvis = !passvis;
                                  });
                                },
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: passvis,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 180,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: isDisabled ? null : signUp,
                            child: Text('Sign Up'),

                            style: ButtonStyle(
                              shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  )),
                              backgroundColor: MaterialStateProperty.all(kDarkBlue),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        TextButton(
                          child: Text("Are you a worker? sign up here.",style: TextStyle(fontSize: 18, color: Colors.deepOrangeAccent),),
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup_worker');
                          },
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                          },
                          child: Text(
                            'Back',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
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

    if(result == null)
      return;
    final path = result.files.single.path;

    setState(() {
      file = File(path);
    });
    await uploadFile();
  }

  Future uploadFile() async {

    if(file == null)
      return;

    final fileName = file.path;
    final destination = 'images/$fileName';
    setState(() {
      imageDestination = destination;
    });

    task = FirebaseApi.uploadFile(destination,file);

    if(task == null ) return;
    
    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('download link $urlDownload');
    imageURL = urlDownload;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image Uploaded Succesfully!'))
    );
    setState(() {
      isDisabled = false;
    });



  }


  void signUp () async {

    if(_formKey.currentState.validate()){
      try {
        //await uploadFile();
        final newUser =
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        _firebaseuser.collection('User').add({
          'mobile_number': mobile_number,
          'full_name': full_name,
          'email': email,
          'password': password,
          'type' : 0,
          'imageURL': imageURL == null ? 'https://firebasestorage.googleapis.com/v0/b/home-services-283bc.appspot.com/o/images%2FUsers%2Fmohammadnassar%2FLibrary%2FDeveloper%2FCoreSimulator%2FDevices%2F82E35996-AB79-45C7-AF14-86024F407A99%2Fdata%2FContainers%2FData%2FApplication%2F4A9AC857-E5C5-4A25-A18C-E6FFEA298EA3%2Ftmp%2Fcom.mhmdnsar.loginPage-Inbox%2FprofilePic.png?alt=media&token=5601c0ca-05f0-47c3-bf09-6336be5ecc54':imageURL ,
        });

        if (newUser != null) {
          Navigator.pushNamed(context, '/Navigation', arguments: {'email': email});
        }
      } catch (e) {
        print(e);
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text('Error'),
            content: Text('This email was already registered.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }
}
