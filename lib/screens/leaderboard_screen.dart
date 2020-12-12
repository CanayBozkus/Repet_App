import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';

class LeaderBoardScreen extends StatelessWidget {
  static const routename = 'LeaderBoardScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(title: 'LeaderBoard', context: context,),
      body: Container(
        width: width,
        height: height*0.8,
        alignment: Alignment.center,
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: width*0.05,
              child: DefaultElevation(
                child: Container(
                  width: width*0.9,
                  height: height * 0.65,
                  color: Colors.white,
                  child: Column(),
                ),
              ),
            ),
            Positioned(
              left: width*0.38,
              child: DefaultElevation(
                isCircular: true,
                child: Container(
                  width: width * 0.24,
                  height: width * 0.24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.public,
                    size: width * 0.18,
                    color: Color(0xff00b1ff),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 3,
      ),
    );
  }
}

