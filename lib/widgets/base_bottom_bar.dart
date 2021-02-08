import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class BaseBottomBar extends StatefulWidget {
  BaseBottomBar({
    Key key,
    @required this.height,
    @required this.width,
    @required this.pageNumber,
  });

  final double height;
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
      height:  widget.height * 0.03 + widget.width*0.16,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: widget.height * 0.08,
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
            bottom: widget.height * 0.02,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 1){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[1]);
                }
              },
              child: Icon(
                bottomNavigationBarIcons[1],
                size: widget.width*0.08,
                color: kPrimaryColor,
              ),
            ),
          ),
          Positioned(
            left: widget.width * 0.26,
            bottom: widget.height * 0.02,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 2){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[2]);
                }
              },
              child: Icon(
                bottomNavigationBarIcons[2],
                size: widget.width*0.08,
                color: kPrimaryColor,
              ),
            ),
          ),
          Positioned(
            left: widget.width * 0.42,
            bottom: widget.height * 0.02,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 3){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[3]);
                }
              },
              child: Container(
                width: widget.width*0.16,
                height: widget.width*0.16,
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
                child: Icon(
                  bottomNavigationBarIcons[3],
                  size: widget.width*0.08,
                  color: widget.pageNumber == 3 ? Colors.white : kPrimaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            right: widget.width * 0.26,
            bottom: widget.height * 0.02,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 4){
                  Navigator.pushNamed(context, bottomNavigationBarRoutes[4]);
                }
              },
              child: Icon(
                bottomNavigationBarIcons[4],
                size: widget.width*0.08,
                color: kPrimaryColor,
              ),
            ),
          ),
          Positioned(
            right: widget.width * 0.08,
            bottom: widget.height * 0.02,
            child: GestureDetector(
              onTap: (){
                if(widget.pageNumber != 5){
                  Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[5]);
                }
              },
              child: Icon(
                bottomNavigationBarIcons[5],
                size: widget.width*0.08,
                color: kPrimaryColor,
              ),
            ),
          ),
          Positioned(
            left: widget.width * selectedLinePosition,
            bottom: widget.height * 0.01,
            child: Container(
              height: showSelectedLine ? 5 : 0,
              width: widget.width*0.08,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
