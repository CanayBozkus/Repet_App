import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/category_card.dart';

class BlogCategoryBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        scrollDirection: Axis.horizontal,
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ...kBlogPageCategoryImages.keys.map((title){
                    return CategoryCard(title: title, svg: kBlogPageCategoryImages[title], color: kBlogPageCategoryColors[title],);
                  }).toList(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
