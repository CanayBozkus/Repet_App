import 'package:flutter/material.dart';
import 'package:repetapp/widgets/default_elevation.dart';

class CalendarDetailRow extends StatelessWidget {
  const CalendarDetailRow({
    @required this.width,
    @required this.checkBoxValue,
    @required this.height,
    this.todoText,
    this.hour,
  });

  final double width;
  final bool checkBoxValue;
  final double height;
  final String todoText;
  final String hour;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Transform.scale(
            scale: (width * 0.06) / 18,
            child: Checkbox(
              value: checkBoxValue,
              onChanged: (value) {},
              activeColor: Color(0xff79c62b),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            todoText,
            style: TextStyle(
              color: Colors.grey.shade500,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: DefaultElevation(
            child: Container(
              width: width * 0.15,
              height: height*0.04,
              alignment: Alignment.center,
              color: Colors.white,
              child: Text(
                hour,
              ),
            ),
          ),
        ),
      ],
    );
  }
}