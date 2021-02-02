import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

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
      height: showDetail ? 220 : 130,
      width: double.maxFinite,
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          showDetail ? Positioned(
            bottom: 0,
            left: 0,
            right:0,
            child: DefaultElevation(
              child: Container(
                height: 110,
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          context.watch<ProvidedData>().pets[context.watch<ProvidedData>().currentShownPetIndex].name,
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
            bottom: showDetail ? 95 : 0,
            left: 0,
            right: 0,
            child: DefaultElevation(
              child: Container(
                width: 110,
                height: 110,
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
            bottom: showDetail ? 120 : 25,
            left: 20,
            child: DefaultElevation(
              child: Container(
                width: 90,
                height: 90,
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
            bottom: showDetail ? 120 : 25,
            right: 20,
            child: DefaultElevation(
              child: Container(
                width: 90,
                height: 90,
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