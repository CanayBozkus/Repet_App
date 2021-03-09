import 'package:flutter/material.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/forum_card.dart';

class ForumView extends StatefulWidget {
  @override
  _ForumViewState createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {
  @override
  void initState() {
    print('in forum');
    ForumModel.getPostPaginatedWithDateTime(DateTime.now(), 10);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
      children: [
        ForumCard(),
        ForumCard(),
        ForumCard(),
        ForumCard(),
        ForumCard(),
        ForumCard(),
      ],
    );
  }
}
