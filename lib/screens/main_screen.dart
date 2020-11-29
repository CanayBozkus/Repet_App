import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/circular_bottom_bar.dart';
import 'package:repetapp/widgets/double_circle_background.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Hatırlatıcı',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        actions: [
          Icon(Icons.menu, color: kPrimaryColor,),
          SizedBox(width: 15.0,),
        ],
      ),
      body: DoubleCircleBackground(
        child: Text('text'),
      ),
      bottomNavigationBar: CircularBottomBar(height: height, width: width,),
    );
  }
}

