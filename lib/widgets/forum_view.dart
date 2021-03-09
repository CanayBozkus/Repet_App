import 'package:flutter/material.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/forum_card.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/widgets/spinner.dart';

class ForumView extends StatefulWidget {
  @override
  _ForumViewState createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {
  List<ForumModel> dataList = [];
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    if(Provider.of<GeneralProviderData>(context, listen: false).forumScreenDataList.isEmpty){
      _getMoreData(DateTime.now());
    }

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        ForumModel lastModel = context.read<GeneralProviderData>().forumScreenDataList.last;
        _getMoreData(lastModel.postedDate);
      }
    });
    super.initState();
  }

  void _getMoreData(DateTime time) async {
    await Provider.of<GeneralProviderData>(context, listen: false).getForumScreenData(time, 10);
  }

  @override
  Widget build(BuildContext context) {
    int length = context.watch<GeneralProviderData>().forumScreenDataList.length;
    List<ForumModel> itemList =  context.watch<GeneralProviderData>().forumScreenDataList;
    return ListView.builder(
      padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
      itemCount: length +1,
      controller: _scrollController,
      itemBuilder: (BuildContext context, int index){
        if(length == 0 || index == length){
          return context.watch<GeneralProviderData>().isAllForumDataFetched ? Text('You have seen all posts') : Spinner();
        }
        ForumModel model = itemList[index];
        return ForumCard(
          category: kForumCategoryTitles[model.category],
          title: model.postedDate.month.toString() + ' ' + model.postedDate.day.toString(),
          content: model.content,
          name: model.ownerName,
          photoSvg: model.ownerPhoto,
          likeCount: model.likeCount,
        );
      },
    );
  }
}
