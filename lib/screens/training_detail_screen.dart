import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class TrainingDetailScreen extends StatefulWidget {
  static const routeName = 'TrainingDetailScreen';
  @override
  _TrainingDetailScreenState createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eğitim',
        ),
        actions: [
          Icon(
            Icons.menu,
            color: kPrimaryColor,
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
    );
  }
}
