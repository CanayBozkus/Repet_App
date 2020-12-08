import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

List<Widget> backgroundHalfCircles(width) {
  return [
    Positioned(
      top: width*0.1,
      left: 0,
      child: Container(
        width: width * 0.4,
        height: width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(width * 0.4),
            bottomRight: Radius.circular(width * 0.4),
          ),
        ),
      ),
    ),
    Positioned(
      bottom: width*0.25,
      right: 0,
      child: Container(
        width: width * 0.4,
        height: width * 0.8,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.4),
            bottomLeft: Radius.circular(width * 0.4),
          ),
        ),
      ),
    ),
  ];
}

Widget trainingStatus({height, status}){
  switch(status){
    case TrainingStatus.done:
      return Container(
        height: height * 0.05,
        width: height * 0.05,
        color: Color(0xff88de2a),
        child: Icon(
          Icons.done,
          color: Colors.white,
          size: height * 0.04,
        ),
      );
    case TrainingStatus.repeat:
      return Container(
        height: height * 0.05,
        width: height * 0.05,
        color: Color(0xffffe500),
        child: Transform.rotate(
          angle: 20.0,
          child: Transform(
            transform: Matrix4.rotationY(3.141),
            alignment: Alignment.center,
            child: Icon(
              Icons.replay,
              color: Colors.white,
              size: height * 0.04,
            ),
          ),
        ),
      );
    case TrainingStatus.notStarted:
      return Container();
    default:
      return Container();
  }
}