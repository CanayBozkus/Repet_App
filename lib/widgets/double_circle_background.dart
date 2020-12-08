import 'package:flutter/material.dart';
import 'package:repetapp/utilities/widget_functions.dart';

class DoubleCircleBackground extends StatelessWidget {
  DoubleCircleBackground({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          ...backgroundHalfCircles(width),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: child,
          ),
        ],
      ),
    );
  }
}
