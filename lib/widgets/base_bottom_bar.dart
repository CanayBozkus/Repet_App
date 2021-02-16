import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseBottomBar extends StatefulWidget {
  BaseBottomBar({
    Key key,

    @required this.width,
    @required this.pageNumber,
  });

  final double width;
  final int pageNumber;

  @override
  _BaseBottomBarState createState() => _BaseBottomBarState();
}

class _BaseBottomBarState extends State<BaseBottomBar> {

  double selectedLinePosition = 0.08;
  bool showSelectedLine = true;

  @override
  Widget build(BuildContext context) {
    switch(widget.pageNumber){
      case 1:
        selectedLinePosition = 0.08;
        break;
      case 2:
        selectedLinePosition = 0.26;
        break;
      case 3:
        showSelectedLine = false;
        break;
      case 4:
        selectedLinePosition = 1 - 0.26 - 0.08;
        break;
      case 5:
        selectedLinePosition = 1 - 0.08 - 0.08;
        break;
      default:
        showSelectedLine = false;
    }
    return Container(
      height: 85,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 3,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: widget.width * 0.08,
            bottom: 15,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 1){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[1]);
                }
              },
              child: SvgPicture.asset(
                bottomNavigationBarIcons[1],
                color: kPrimaryColor,
                height: 28,
              ),
            ),
          ),
          Positioned(
            left: widget.width * 0.26,
            bottom: 15,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 2){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[2]);
                }
              },
              child: SvgPicture.asset(
                bottomNavigationBarIcons[2],
                color: kPrimaryColor,
                height: 28,
              ),
            ),
          ),
          Positioned(
            left: widget.width * 0.42,
            bottom: 15,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 3){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[3]);
                }
              },
              child: Container(
                width: 70,
                height: 70,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.pageNumber == 3 ? kPrimaryColor : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      spreadRadius: 3,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  bottomNavigationBarIcons[3],
                  color: widget.pageNumber == 3 ? Colors.white : kPrimaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: widget.width * 0.26,
            bottom: 15,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 4){
                  Navigator.pushNamed(context, bottomNavigationBarRoutes[4]);
                }
              },
              child: SvgPicture.asset(
                bottomNavigationBarIcons[4],
                color: kPrimaryColor,
                height: 28,
              ),
            ),
          ),
          Positioned(
            right: widget.width * 0.08,
            bottom: 15,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 5){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[5]);
                }
              },
              child:SvgPicture.asset(
                bottomNavigationBarIcons[5],
                color: kPrimaryColor,
                height: 28,
              ),
            ),
          ),
          Positioned(
            left: widget.width * selectedLinePosition,
            bottom: 8,
            child: Container(
              height: showSelectedLine ? 5 : 0,
              width: 28,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
