import 'package:flutter/material.dart';
import 'package:login_page/constants.dart';

import 'Services.dart';
class CreateText extends StatelessWidget {
  final TextInputType keyboard;
  final String hinttxt;
  final Icon ico;
  final String lbltxt;
  final TextStyle lblStyle=TextStyle(fontSize: 18.0,color: Colors.black87,);
  final TextStyle hintstyle=TextStyle(fontSize: 18.0,color: Colors.black12,);
  final Function onChanged;
  final formKey;
  final String type;

  CreateText({this.keyboard,this.hinttxt,this.ico,this.lbltxt,this.onChanged,this.formKey,this.type});

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        key: key,
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          switch(type){
            case 'mobile': return !validateMobile(value) ? 'Mobile number must be at least 10 digits' : null;
            case 'email': return !validateEmail(value) ? 'Please enter your email correctly' : null;
          }
            return null;
          },

        //controller: control,
        decoration: InputDecoration(

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kDarkBlue),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(width: 1,color:kDarkBlue),
          ),

          fillColor: Colors.white,
          filled: true,
          labelText: lbltxt,
          labelStyle: lblStyle,
          icon: ico,
          hintText: hinttxt,
          hintStyle:hintstyle,

        ),
        keyboardType: keyboard,

        onChanged: onChanged,
      ),
    );
  }
}
