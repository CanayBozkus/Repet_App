import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({this.onPressed, this.width, this.text, this.empty = false, this.fontSize = 20, this.backgroundColor = kPrimaryColor});
  final double width;
  final Function onPressed;
  final String text;
  final bool empty;
  final double fontSize;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: fontSize*2.5,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: FlatButton(
        color: !empty ? backgroundColor : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: empty ? BorderSide(
            color: backgroundColor,
            width: 1.5,
            style: BorderStyle.solid,
          ) : BorderSide.none,
        ),
        padding: EdgeInsets.symmetric(vertical: fontSize/2, horizontal: fontSize*2),
        minWidth: width ?? double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: empty ? backgroundColor : Colors.white,
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed ?? (){},
      ),
    );
  }
}