import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/double_circle_background.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: DoubleCircleBackground(),
      ),
    );
  }
}
