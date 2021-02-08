import 'package:flutter/material.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ForumCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: DefaultElevation(
        child: Container(
          height: 150,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset('assets/icons/profile.svg', height: 70,),
                    Text('Peter Watts',),
                    DefaultElevation(
                      child: Container(
                        width: 90,
                        height: 24,
                        alignment: Alignment.center,
                        color: Color(0xff54ac14),
                        child: Text(
                          'Care',
                          style: TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Puppy Care',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                    Text(
                      'If the time is right for getting a puppy you will now have to choose the best match. Perhaps your future Perhaps your future Perhaps your future Perhaps your future Perhaps your future',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite, color: Color(0xffff3636),),
                        Text('79'),
                      ],
                    )
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