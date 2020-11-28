import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonLeadingSvg extends StatelessWidget {
  const ButtonLeadingSvg({
    @required this.width,
    @required this.svg,
    @required this.label,
    @required this.onPressed,
    @required this.color,
  }) ;

  final double width;
  final String svg;
  final String label;
  final Function onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      color: color,
      child: Container(
        width: width,
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SvgPicture.asset(
              svg,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: width*0.12
              ),
            )
          ],
        ),
      ),
    );
  }
}