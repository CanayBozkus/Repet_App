import 'package:flutter/material.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RemainderRow extends StatelessWidget {
  RemainderRow({this.svg, this.mainText, this.subText, this.svgColor, this.onTap});
  final String svg;
  final String mainText;
  final String subText;
  final Color svgColor;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: 5,
        child: ListTile(
          onTap: onTap,
          leading: SvgPicture.asset(
            svg,
            height: 40,
            color: svgColor,
          ),
          title: Text(
            mainText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Text(
            subText,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SvgPicture.asset('assets/icons/clock.svg'),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    '%100',
                    style: TextStyle(

                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
Padding(
padding: EdgeInsets.only(bottom: height * 0.03),
child: DefaultElevation(
child: Container(
width: double.infinity,
height: 75.0,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Expanded(
flex: 2,
child: SvgPicture.asset(
svg,
height: 40,
),
),
Expanded(
flex: 4,
child: Column(
mainAxisAlignment:
MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
mainText,
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.w800,
),
),
Text(
subText,
style: TextStyle(
fontSize: 14,
),
),
],
),
),
Expanded(
flex: 3,
child: Row(
children: [
Material(
elevation: 3,
child: Container(
padding: EdgeInsets.all(8),
height: 50,
width: 50,
child: SvgPicture.asset('assets/icons/clock.svg'),
),
),
SizedBox(
width: width * 0.02,
),
Container(
height: 50,
width: 50,
alignment: Alignment.center,
color: Color(0xffffdf00),
child: Text(
'0',
style: TextStyle(
color: Colors.white,
fontSize: height * 0.05,
),
),
),
],
),
),
],
),
),
),
)
*/