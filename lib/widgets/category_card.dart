import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
class CategoryCard extends StatelessWidget {
  final ForumCategories category;
  CategoryCard({this.category});
  @override
  Widget build(BuildContext context) {
    final List filterList = context.watch<GeneralProviderData>().blogScreenFilter;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: BaseShadow(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Material(
          child: InkWell(
            onTap: (){
              context.read<GeneralProviderData>().filterForumScreenBlogDataListView(category);
            },
            child: Container(
              height: 80,
              width: 100,
              padding: EdgeInsets.all(10),
              color: filterList.contains(category) && filterList.length == 1 ? kBlogPageCategoryColors[category].withOpacity(0.1) : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.asset(kBlogPageCategoryImages[category], height: 25,),
                  Text(
                    kForumCategoryTitles[category],
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: kBlogPageCategoryColors[category],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
