import 'package:flutter/material.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RemainderRow extends StatelessWidget {
  RemainderRow({@required this.width, @required this.height, this.svg, this.mainText, this.subText});
  final double height;
  final double width;
  final String svg;
  final String mainText;
  final String subText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.03),
      child: DefaultElevation(
        child: Container(
          width: double.infinity,
          height: height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: SvgPicture.asset(
                  svg,
                  height: height * 0.08,
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
                        color: Colors.black,
                        fontSize: height * 0.03,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      subText,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: height * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Container(
                      height: height * 0.07,
                      width: height * 0.07,
                      color: Color(0xffc1c1c1),
                      child: Icon(
                        FontAwesomeIcons.clock,
                        size: height * 0.05,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      height: height * 0.07,
                      width: height * 0.07,
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
    );
  }
}
