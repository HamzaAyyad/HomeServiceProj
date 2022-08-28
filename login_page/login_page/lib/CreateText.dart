import 'package:flutter/material.dart';
class CreateText extends StatelessWidget {
  final TextInputType keyboard;
  final String hinttxt;
  final Icon ico;
  final String lbltxt;
  final TextStyle lblStyle=TextStyle(fontSize: 18.0,color: Colors.black87,);
  final TextStyle hintstyle=TextStyle(fontSize: 18.0,color: Colors.black12,);


  CreateText({this.keyboard,this.hinttxt,this.ico,this.lbltxt});

  @override
  Widget build(BuildContext context) {


    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextField(
        //controller: control,
        decoration: InputDecoration(

          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: BorderSide(width: 1,color: Colors.green.shade700),




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

      ),
    );
  }
}
