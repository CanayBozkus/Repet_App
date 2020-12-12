import 'package:flutter/material.dart';

class DefaultElevation extends StatelessWidget {
  DefaultElevation({this.child, this.isCircular = false});
  final Widget child;
  final bool isCircular;
  @override
  Widget build(BuildContext context) {
    return  Material(
      shadowColor: Colors.grey.shade400,
      color: Colors.white,
      elevation: 5,
      child: child,
      shape: isCircular ? CircleBorder() : null,
    );
  }
}
