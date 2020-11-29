import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Text('Text'),
      ),
      bottomNavigationBar: Container(
        color: Colors.blue,
        height: height * 0.15,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.red,
              ),
            ),
            Positioned(
              left: width * 0.1,
              bottom: height * 0.02,
              child: Icon(
                Icons.home_outlined,
                size: width*0.08,
              ),
            ),
            Positioned(
              left: width * 0.3,
              bottom: height * 0.02,
              child: Icon(
                Icons.date_range,
                size: width*0.08,
              ),
            ),
            Positioned(
              left: width * 0.42,
              bottom: height * 0.03,
              child: Container(
                width: width*0.16,
                height: width*0.16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 3,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: Icon(
                  FontAwesomeIcons.trophy,
                  size: width*0.08,
                ),
              ),
            ),
            Positioned(
              left: width * 0.6,
              bottom: height * 0.02,
              child: Icon(
                Icons.messenger_rounded,
                size: width*0.08,
              ),
            ),
            Positioned(
              left: width * 0.8,
              bottom: height * 0.02,
              child: Icon(
                Icons.school,
                size: width*0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
