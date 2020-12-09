import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/circular_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/double_circle_background.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/widgets/remainder_row.dart';

class MainScreen extends StatelessWidget {
  static const routeName = 'MainScreen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hatırlatıcı',
        ),
        actions: [
          Icon(
            Icons.menu,
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
      body: DoubleCircleBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PetNavigator(height: height, width: width, showDetail: true,),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: height * 0.01,
                ),
                child: ListView(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.08, vertical: height * 0.02),
                  children: [
                    RemainderRow(
                      height: height,
                      width: width,
                      mainText: 'Beslenme',
                      subText: 'Günde 2 defa',
                      svg: 'assets/icons/dog.svg',
                    ),
                    RemainderRow(
                      height: height,
                      width: width,
                      mainText: 'Beslenme',
                      subText: 'Günde 2 defa',
                      svg: 'assets/icons/dog.svg',
                    ),
                    RemainderRow(
                      height: height,
                      width: width,
                      mainText: 'Beslenme',
                      subText: 'Günde 2 defa',
                      svg: 'assets/icons/dog.svg',
                    ),
                    RemainderRow(
                      height: height,
                      width: width,
                      mainText: 'Beslenme',
                      subText: 'Günde 2 defa',
                      svg: 'assets/icons/dog.svg',
                    ),
                    RemainderRow(
                      height: height,
                      width: width,
                      mainText: 'Beslenme',
                      subText: 'Günde 2 defa',
                      svg: 'assets/icons/dog.svg',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CircularBottomBar(
        height: height,
        width: width,
        pageNumber: 1,
      ),
    );
  }
}

