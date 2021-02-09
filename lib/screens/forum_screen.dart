import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/widgets/blog_category_builder.dart';
import 'package:repetapp/widgets/category_card.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/forum_card.dart';

class ForumScreen extends StatefulWidget {
  static const routeName = 'ForumScreen';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: selected == 0 ? FloatingActionButton(
        child: Icon(
          Icons.add,
          color: kPrimaryColor,
          size: 45,
        ),
        backgroundColor: Colors.white,
        onPressed: (){},
      ) : null,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BaseButton(
                  text: 'Forum',
                  onPressed: (){
                    setState(() {
                      selected = 0;
                    });
                  },
                  width: 150,
                  empty: !(selected == 0),
                ),
                BaseButton(
                  text: 'Blog',
                  onPressed: (){
                    setState(() {
                      selected = 1;
                    });
                  },
                  width: 150,
                  empty: selected == 0,
                ),
              ],
            ),
            SizedBox(height: 10,),
            BlogCategoryBuilder(),
            Expanded(
              child: ListView(
                padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
                children: [
                  ForumCard(),
                  ForumCard(),
                  ForumCard(),
                  ForumCard(),
                  ForumCard(),
                  ForumCard(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 4,
      ),
    );
  }
}
