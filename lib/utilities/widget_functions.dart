import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

List<Widget> backgroundHalfCircles(width) {
  return [
    Positioned(
      top: width*0.05,
      left: 0,
      child: Container(
        width: width * 0.5,
        height: width,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(width * 0.5),
            bottomRight: Radius.circular(width * 0.5),
          ),
        ),
      ),
    ),
    Positioned(
      bottom: width*0.05,
      right: 0,
      child: Container(
        width: width * 0.5,
        height: width,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.5),
            bottomLeft: Radius.circular(width * 0.5),
          ),
        ),
      ),
    ),
  ];
}
