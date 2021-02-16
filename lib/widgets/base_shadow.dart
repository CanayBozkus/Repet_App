import 'package:flutter/material.dart';

class BaseShadow extends StatelessWidget {
  final Widget child;
  final bool isCircular;
  final BorderRadius borderRadius;
  BaseShadow({this.child, this.isCircular = false, this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
