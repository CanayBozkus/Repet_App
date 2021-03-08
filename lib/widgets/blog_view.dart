import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/blog_category_builder.dart';
import 'package:repetapp/widgets/forum_card.dart';

class BlogView extends StatefulWidget {
  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  @override
  void initState() {
    print('in blog');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ListView(
      children: [
        BlogCategoryBuilder(),
        Padding(
          padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
          child: Column(
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
    );
  }
}
