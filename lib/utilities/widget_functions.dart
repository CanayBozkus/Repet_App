import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';


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