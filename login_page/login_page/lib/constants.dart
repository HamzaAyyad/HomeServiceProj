import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color kMainGreenColor = Color(0xFF189A4F);
const kTextFieldInputUsernameDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Enter Email',
    prefixIcon: Icon(Icons.person,color: kDarkBlue,size: 30,),
    hintStyle: TextStyle(
        color: Colors.grey
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    )
);
const kTextFieldInputDecorationPassword = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    hintText: 'Enter Password',
    prefixIcon: Icon(Icons.lock,color: kDarkBlue,size: 30,),
    hintStyle: TextStyle(
        color: Colors.grey
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    )
);
const kTextFieldInputDecorationSignup = InputDecoration(
    filled: true,
    fillColor: Color(0xffF3F3F3),
    hintStyle: TextStyle(
        color: Colors.grey
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    )
);
const kLabelTextDecoration = TextStyle();
const kLighGreenBackGround = Color(0x20189A4F);

const kLightBlueBackground = Color(0xFFEAF4F4);
const kDarkBlue = Color(0xFF1D3557);
const kLightBlue = Color(0xFF457B9D);
const red = Color(0xFFE63946);
const kStarColor = Color(0xFFF7BD57);