import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/circular_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/double_circle_background.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/widgets/remainder_row.dart';

class MainScreen extends StatelessWidget {
  static const routeName = 'MainScreen';

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Hatırlatıcı',
          style: TextStyle(
            color: kPrimaryColor,
          ),
        ),
        actions: [
          Icon(
            Icons.menu,
            color: kPrimaryColor,
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
            Container(
              height: height * 0.3,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
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
                  ),
                  Positioned(
                    left: width * 0.03,
                    bottom: height * 0.025,
                    child: DefaultElevation(
                      child: Container(
                        width: width * 0.08,
                        height: height * 0.1,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: kPrimaryColor,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: width * 0.03,
                    bottom: height * 0.025,
                    child: DefaultElevation(
                      child: Container(
                        width: width * 0.08,
                        height: height * 0.1,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          color: kPrimaryColor,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: height * 0.03,
                    left: width * 0.36,
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
                    top: height * 0.02,
                    left: width * 0.1,
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
                    top: height * 0.02,
                    right: width * 0.1,
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
      bottomNavigationBar: CircularBottomBar(
        height: height,
        width: width,
      ),
    );
  }
}
