import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/double_circle_background.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/widgets/remainder_row.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScreen extends StatelessWidget {
  static const routeName = 'MainScreen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(title: 'Hatırlatıcı', context: context,),
      body: DoubleCircleBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PetNavigator(
              height: height,
              width: width,
              showDetail: true,
            ),
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
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 1,
      ),
    );
  }
}
