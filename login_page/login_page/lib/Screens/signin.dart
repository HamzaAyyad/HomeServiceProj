import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/HelpWidget/NavigationDrawer.dart';
import 'package:login_page/HelpWidget/Services.dart';
import 'package:login_page/Screens/Customer/home_page.dart';
import 'package:login_page/constants.dart';

import 'first_screen.dart';

class SignIn extends StatelessWidget {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: kDarkBlue,
        title: Text('Sign in'),
      ),
      body: Container(
        color: kLightBlueBackground,
        child: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/blueLogo.png',
                    scale: 3.5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Home Service',
                    style: TextStyle(
                        fontFamily: 'Pacifico', fontSize: 35, color: kDarkBlue),
                  ),
                  SizedBox(
                    height: 65,
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: 325,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: kTextFieldInputUsernameDecoration,
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              } else if(!validateEmail(value)){
                                return 'Please enter your email correctly';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: 325,
                          child: TextFormField(
                            obscureText: true,
                            decoration: kTextFieldInputDecorationPassword,
                            onChanged: (value) {
                              password = value;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text.';
                              } else if(!validatePassword(value)){
                                return 'Password must be at least 6 letters.';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        getSignInButton(context: context),
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

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSignInButton({BuildContext context}) {
    String route;
    String title = 'Sign in!';


    return Container(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: () async {

          //check form validation
          if (_formKey.currentState.validate()){
          try {
            final user = await _auth.signInWithEmailAndPassword(email: email, password: password);


            var collection = FirebaseFirestore.instance.collection('User');

            String id;
            collection
                .where('email',isEqualTo: email)
                .get()
                .then((QuerySnapshot snapshot) => {
              snapshot.docs.forEach((f) {
                print("documentID---- " + f.reference.id);
                id = f.reference.id;
                collection
                    .doc(id)
                    .get().then((value){
                  print(value.data()['type']);
                  if(value.data()['type'] == 0)
                    route = '/Navigation';
                  else
                    route = '/WorkerNavigation';
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, route,arguments: {
                      'email' : email
                    });
                  }
                });
              }),
            },
            );


          } catch (e) {
            List<String> splitted = e.toString().split(" ");
            String code = splitted.take(1).toString();
            print(code);
            String content = 'Your email is not registered';
            //check the cause of the error
            if(code == '([firebase_auth/user-not-found])')
              content = 'Your email is not registered';
            else
              content = 'Your password is incorrect';

              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Error'),
                  content: Text(content),
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
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          )),
          backgroundColor: MaterialStateProperty.all(kDarkBlue),
        ),
      ),
    );
  }
}

