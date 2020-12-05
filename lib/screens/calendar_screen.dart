import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/calendar.dart';
import 'package:repetapp/widgets/circular_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/double_circle_background.dart';


class CalendarScreen extends StatelessWidget {
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
          'Takvim',
          style: TextStyle(
            color: kPrimaryColor,
          ),
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
      body: DoubleCircleBackground(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(width*0.04),
              child: DefaultElevation(
                child: Container(
                  padding: EdgeInsets.all(width*0.02),
                  color: Colors.white,
                  child: Calendar(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircularBottomBar(
        height: height,
        width: width,
      ),
    );
  }
}
