import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

List<Widget> backgroundHalfCircles(width) {
  return [
    Positioned(
      top: width*0.1,
      left: 0,
      child: Container(
        width: width * 0.4,
        height: width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(width * 0.4),
            bottomRight: Radius.circular(width * 0.4),
          ),
        ),
      ),
    ),
    Positioned(
      bottom: width*0.25,
      right: 0,
      child: Container(
        width: width * 0.4,
        height: width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.4),
            bottomLeft: Radius.circular(width * 0.4),
          ),
        ),
      ),
    ),
  ];
}
