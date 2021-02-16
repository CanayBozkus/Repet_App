import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/widget_functions.dart';
import 'package:repetapp/widgets/base_shadow.dart';

class TrainingBuilderRow extends StatelessWidget {
  const TrainingBuilderRow(
      {Key key,
      @required this.height,
      @required this.width,
      this.text,
      this.status,
      this.onTap});

  final double height;
  final double width;
  final String text;
  final TrainingStatus status;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.02),
      child: BaseShadow(
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: height * 0.07,
            width: double.infinity,
            padding: EdgeInsets.only(left: width * 0.1, right: width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                ),
                trainingStatus(height: height, status: status),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
