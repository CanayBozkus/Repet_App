import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({this.onPressed, this.width, this.text});
  final double width;
  final Function onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey.shade400,
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: FlatButton(
        color: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40),
        minWidth: width ?? double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed ?? (){},
      ),
    );
  }
}