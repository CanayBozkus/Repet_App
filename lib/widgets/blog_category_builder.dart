import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/widgets/category_card.dart';

class BlogCategoryBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        scrollDirection: Axis.horizontal,
        children: [
          BaseShadow(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  ...ForumCategories.values.map((category){
                    return CategoryCard(title: kForumCategoryTitles[category], svg: kBlogPageCategoryImages[category], color: kBlogPageCategoryColors[category],);
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
