import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  static const routeName = 'ErrorScreen';
  final errorMsg;
  ErrorScreen({this.errorMsg});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Center(
          child: Text(
            errorMsg ?? 'Error',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
