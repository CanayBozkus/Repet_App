import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    this.onPressed,
    this.width,
    this.text,
    this.empty = false,
    this.fontSize = 20,
    this.backgroundColor = kPrimaryColor,
    this.isActive = true,
  });
  final double width;
  final Function onPressed;
  final String text;
  final bool empty;
  final double fontSize;
  final Color backgroundColor;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return BaseShadow(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: fontSize*2.5,
        child: FlatButton(
          disabledColor: backgroundColor.withOpacity(0.8),
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
          onPressed: onPressed,
        ),
      ),
    );
  }
}