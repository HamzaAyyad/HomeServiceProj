import 'dart:math';
import 'package:login_page/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Screens/Customer/customer_signup.dart';
import 'package:login_page/Screens/signin.dart';
import 'package:login_page/Screens/worker_signup.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Screens/first_screen.dart';
import 'package:firebase_core/firebase_core.dart';



class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: kLightBlueBackground,
          // image: DecorationImage(
          //   image: AssetImage("images/backGround.png"),
          //   fit: BoxFit.cover,
          // ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/blueLogo.png',scale: 2,),
              //Image.asset('images/icons.png',scale: 2,width: 200,),
              SizedBox(height: 40,),
              //sign in button
              SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: (){
                      // DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("Username");
                      // _testRef.set("hello world ${Random().nextInt(100)}");

                      // Navigator.push(context, MaterialPageRoute(builder: (context){
                      //   return SignIn();
                      // }));
                      Navigator.pushReplacementNamed(context, '/signin');
                    },
                    child: Text('Sign in',style: TextStyle(fontSize: 15),),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                      ),
                      backgroundColor: MaterialStateProperty.all(kDarkBlue),
                    ),
                  )
              ),
              Row(
                  children: <Widget>[
                    Expanded(
                        child: Divider(thickness: 3,height: 30,indent: 50,endIndent: 10)
                    ),

                    Text("Don't have an account?",style: TextStyle(fontSize: 18, color: Colors.grey.shade700),),

                    Expanded(
                        child: Divider(thickness: 3,height: 30,endIndent: 50,indent: 10,)
                    ),
                  ]
              ),

              //sign up button as customer
              SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement( context, MaterialPageRoute(builder: (context){
                        return CustomerSignup();
                      }));
                    },
                    child: Text('Sign Up!',style: TextStyle(fontSize: 15, color: kDarkBlue),),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          )
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                  )
              ),

              //sign up button as worker
              // SizedBox(
              //     width: 250,
              //     child: ElevatedButton(
              //       onPressed: (){
              //         Navigator.push( context, MaterialPageRoute(builder: (context){
              //           return WorkerSignup();
              //         }));
              //       },
              //       child: Text('Sign Up as a Worker!',style: TextStyle(fontSize: 15, color: kDarkBlue),),
              //       style: ButtonStyle(
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(18.0),
              //             )
              //         ),
              //         backgroundColor: MaterialStateProperty.all(Colors.white),
              //       ),
              //     )
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

