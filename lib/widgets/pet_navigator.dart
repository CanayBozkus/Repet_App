

import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetNavigator extends StatelessWidget {
  const PetNavigator({
    @required this.height,
    @required this.width,
    this.showDetail = false,
  });

  final double height;
  final double width;
  final bool showDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: showDetail ? height * 0.30 : height * 0.2,
      width: double.infinity,
      child: Stack(
        children: [
          showDetail ? Positioned(
            bottom: 0,
            left: width * 0.08,
            child: DefaultElevation(
              child: Container(
                width: width * 0.84,
                height: height * 0.15,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.08, vertical: height * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Rıfkı',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Pug',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff7654ff),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Veteriner Kontrolleri Yapıldı'),
                        Text('8 Aylık'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ) : SizedBox.shrink(),
          Positioned(
            top: height * 0.03,
            left: width * 0.37,
            child: DefaultElevation(
              child: Container(
                width: width * 0.26,
                height: width * 0.26,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset(
                  'assets/icons/dog.svg',
                  color: Color(0xffba892b),
                ),
              ),
              isCircular: true,
            ),
          ),
          Positioned(
            top: height * 0.005,
            left: width * 0.12,
            child: DefaultElevation(
              child: Container(
                width: width * 0.2,
                height: width * 0.2,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset(
                  'assets/icons/fish.svg',
                  color: Color(0xff6da3d9),
                ),
              ),
              isCircular: true,
            ),
          ),
          Positioned(
            top: height * 0.005,
            right: width * 0.12,
            child: DefaultElevation(
              child: Container(
                width: width * 0.2,
                height: width * 0.2,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset(
                  'assets/icons/cat.svg',
                  color: Color(0xffe86868),
                ),
              ),
              isCircular: true,
            ),
          ),
        ],
      ),
    );
  }
}