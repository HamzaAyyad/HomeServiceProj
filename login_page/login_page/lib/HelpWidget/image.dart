import 'package:flutter/material.dart';
import 'package:login_page/constants.dart';
class RoundIconButton extends StatelessWidget {
  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 75.0,
        height: 75.0,
      ),
      shape: CircleBorder(),
      fillColor: kLightBlue,
    );
  }
}