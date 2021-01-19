import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonLeadingSvg extends StatelessWidget {
  const ButtonLeadingSvg({
    this.width = double.infinity,
    @required this.svg,
    @required this.label,
    @required this.onPressed,
    @required this.color,
    this.fontSize = 18.0,
  }) ;

  final double width;
  final String svg;
  final String label;
  final Function onPressed;
  final Color color;
  final fontSize;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        width: width,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            SvgPicture.asset(
              svg,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: fontSize,
                  ),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}