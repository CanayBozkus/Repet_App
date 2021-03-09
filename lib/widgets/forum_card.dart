import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ForumCard extends StatelessWidget {
  ForumCard({this.category, this.name, this.content, this.title, this.photoSvg, this.likeCount});
  final String name;
  final String category;
  final String title;
  final String content;
  final String photoSvg;
  final int likeCount;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: BaseShadow(
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
                    SvgPicture.asset('assets/icons/$photoSvg', height: 70,),
                    Text(name,),
                    BaseShadow(
                      child: Container(
                        width: 90,
                        height: 24,
                        alignment: Alignment.center,
                        color: Color(0xff54ac14),
                        child: Text(
                          category,
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
                        title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                    Text(
                      content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite, color: Color(0xffff3636),),
                        Text(likeCount.toString()),
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