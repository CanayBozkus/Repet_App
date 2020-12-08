import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/widget_functions.dart';
import 'package:repetapp/widgets/default_elevation.dart';

class TrainingDetailRow extends StatelessWidget {
  const TrainingDetailRow(
      {Key key,
      @required this.height,
      @required this.width,
      this.text,
      this.status});

  final double height;
  final double width;
  final String text;
  final TrainingStatus status;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: DefaultElevation(
        child: Container(
          height: height * 0.07,
          width: double.infinity,
          padding: EdgeInsets.only(left: width * 0.1, right: width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trainingStatus(height: height, status: status),
            ],
          ),
        ),
      ),
    );
  }
}
