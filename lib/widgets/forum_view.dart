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
  List<ForumModel> _itemList = [];
  int _length;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    if(Provider.of<GeneralProviderData>(context, listen: false).forumScreenForumDataList.isEmpty){
      _getMoreData(DateTime.now());
    }

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        ForumModel lastModel = context.read<GeneralProviderData>().forumScreenForumDataList.last;
        _getMoreData(lastModel.postedDate);
      }
    });
    super.initState();
  }

  void _getMoreData(DateTime time) async {
    await Provider.of<GeneralProviderData>(context, listen: false).getForumScreenForumData(time, 10);
  }

  @override
  Widget build(BuildContext context) {
    _length = context.watch<GeneralProviderData>().forumScreenForumDataList.length;
    _itemList =  context.watch<GeneralProviderData>().forumScreenForumDataList;
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GeneralProviderData>().refreshForumScreenForumData();
      },
      child: ListView.builder(
        padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
        itemCount: _length +1,
        controller: _scrollController,
        itemBuilder: (BuildContext context, int index){
          if(_length == 0 || index == _length){
            return context.watch<GeneralProviderData>().isAllForumScreenForumDataFetched
                ? Text(_length == 0 ? 'There are no available post' : 'You have seen all posts')
                : Spinner();
          }
          ForumModel model = _itemList[index];
          return ForumCard(
            forumModel: model,
            cardType: ForumCardTypes.summary,
          );
        },
      ),
    );
  }
}
