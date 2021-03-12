import 'package:flutter/material.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/blog_category_builder.dart';
import 'package:repetapp/widgets/forum_card.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/widgets/spinner.dart';

class BlogView extends StatefulWidget {
  @override
  _BlogViewState createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  List<ForumModel> _itemList = [];
  int _length;
  ScrollController _scrollController = ScrollController();
  List<ForumCategories> _filterList;
  @override
  void initState() {
    if(Provider.of<GeneralProviderData>(context, listen: false).forumScreenBlogDataList.isEmpty){
      _getMoreData(DateTime.now());
    }

    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        ForumModel lastModel = context.read<GeneralProviderData>().forumScreenBlogDataList.last;
        _getMoreData(lastModel.postedDate);
      }
    });
    super.initState();
  }

  void _getMoreData(DateTime time) async {
    await Provider.of<GeneralProviderData>(context, listen: false).getForumScreenBlogData(time, 10);
  }

  @override
  Widget build(BuildContext context) {
    _filterList = context.watch<GeneralProviderData>().blogScreenFilter;
    _itemList =  context.watch<GeneralProviderData>().forumScreenBlogDataList.where((item) => _filterList.contains(item.category)).toList();
    _length = _itemList.length;
    return Column(
      children: [
        BlogCategoryBuilder(),
        Expanded(
          child: ListView.builder(
            padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
            itemCount: _length +1,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index){
              if(_length == 0 || index == _length){
                return context.watch<GeneralProviderData>().isAllForumScreenBlogDataFetched
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
        ),
      ],
    );
  }
}
