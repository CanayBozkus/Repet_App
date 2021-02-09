import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CategoryCard extends StatelessWidget {
  final String title;
  final String svg;
  final Color color;
  CategoryCard({this.title, this.svg, this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          height: 80,
          width: 100,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(svg, height: 25,),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
