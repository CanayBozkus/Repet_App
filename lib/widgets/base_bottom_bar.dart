import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseBottomBar extends StatefulWidget {
  BaseBottomBar({
    Key key,
    @required this.pageNumber,
  });

  final int pageNumber;

  @override
  _BaseBottomBarState createState() => _BaseBottomBarState();
}

class _BaseBottomBarState extends State<BaseBottomBar> {

  bool showSelectedLine = true;

  @override
  Widget build(BuildContext context) {
    if(widget.pageNumber == 3 || widget.pageNumber < 0 || widget.pageNumber > 5 || widget.pageNumber == null){
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
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
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
                    SizedBox(height: 5,),
                    Container(
                      height: 5,
                      width: 28,
                      color: showSelectedLine && widget.pageNumber == 1 ? kPrimaryColor : Colors.white,
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
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
                    SizedBox(height: 5,),
                    Container(
                      height: 5,
                      width: 28,
                      color: showSelectedLine && widget.pageNumber == 2 ? kPrimaryColor : Colors.white,
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
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
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        if(widget.pageNumber != 4){
                          Navigator.pushReplacementNamed(context, bottomNavigationBarRoutes[4]);
                        }
                      },
                      child: SvgPicture.asset(
                        bottomNavigationBarIcons[4],
                        color: kPrimaryColor,
                        height: 28,
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: 5,
                      width: 28,
                      color: showSelectedLine && widget.pageNumber == 4 ? kPrimaryColor : Colors.white,
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
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
                    SizedBox(height: 5,),
                    Container(
                      height: 5,
                      width: 28,
                      color: showSelectedLine && widget.pageNumber == 5 ? kPrimaryColor : Colors.white,
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

