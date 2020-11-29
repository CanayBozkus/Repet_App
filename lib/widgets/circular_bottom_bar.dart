import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CircularBottomBar extends StatefulWidget {
  CircularBottomBar({
    Key key,
    @required this.height,
    @required this.width,
  });

  final double height;
  final double width;

  @override
  _CircularBottomBarState createState() => _CircularBottomBarState();
}

class _CircularBottomBarState extends State<CircularBottomBar> {

  double selectedLinePosition = 0.08;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: widget.height * 0.08,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  spreadRadius: 3,
                  offset: Offset(0, 0),
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: widget.width * 0.08,
          bottom: widget.height * 0.02,
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedLinePosition = 0.08;
              },);
            },
            child: Icon(
              Icons.home_outlined,
              size: widget.width*0.08,
              color: kPrimaryColor,
            ),
          ),
        ),
        Positioned(
          left: widget.width * 0.26,
          bottom: widget.height * 0.02,
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedLinePosition = 0.26;
              },);
            },
            child: Icon(
              Icons.date_range,
              size: widget.width*0.08,
              color: kPrimaryColor,
            ),
          ),
        ),
        Positioned(
          left: widget.width * 0.42,
          bottom: widget.height * 0.02,
          child: GestureDetector(
            onTap: (){
              setState(() {

              },);
            },
            child: Container(
              width: widget.width*0.16,
              height: widget.width*0.16,
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
                size: widget.width*0.08,
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
        Positioned(
          right: widget.width * 0.26,
          bottom: widget.height * 0.02,
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedLinePosition = 1 - 0.26 - 0.08;
              },);
            },
            child: Icon(
              Icons.messenger_rounded,
              size: widget.width*0.08,
              color: kPrimaryColor,
            ),
          ),
        ),
        Positioned(
          right: widget.width * 0.08,
          bottom: widget.height * 0.02,
          child: GestureDetector(
            onTap: (){
              setState(() {
                selectedLinePosition = 1 - 0.08 - 0.08;
              },);
            },
            child: Icon(
              Icons.school,
              size: widget.width*0.08,
              color: kPrimaryColor,
            ),
          ),
        ),
        Positioned(
          left: widget.width * selectedLinePosition,
          bottom: widget.height * 0.01,
          child: Container(
            height: 5,
            width: widget.width*0.08,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }
}