import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({this.onPressed, this.width, this.text, this.empty = false});
  final double width;
  final Function onPressed;
  final String text;
  final bool empty;
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey.shade400,
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: FlatButton(
        color: !empty ? kPrimaryColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: empty ? BorderSide(
            color: kPrimaryColor,
            width: 1.5,
            style: BorderStyle.solid,
          ) : BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40),
        minWidth: width ?? double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: empty ? kPrimaryColor : Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed ?? (){},
      ),
    );
  }
}