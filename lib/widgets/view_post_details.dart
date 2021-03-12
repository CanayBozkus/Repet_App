import 'package:flutter/material.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/widgets/forum_card.dart';
import 'package:repetapp/widgets/spinner.dart';

class ViewPostDetails extends StatefulWidget {
  ViewPostDetails({this.forumModel});
  final ForumModel forumModel;

  @override
  _ViewPostDetailsState createState() => _ViewPostDetailsState();
}

class _ViewPostDetailsState extends State<ViewPostDetails> {
  List<ForumModel> _itemList = [];
  int _length;
  ScrollController _scrollController = ScrollController();
  ForumModel _comment = ForumModel();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    Provider.of<GeneralProviderData>(context, listen: false).initializeCommentVariables();
    if(Provider.of<GeneralProviderData>(context, listen: false).forumScreenCommentsList.isEmpty){
      Provider.of<GeneralProviderData>(context, listen: false).addItemToCommentsList(widget.forumModel);
      _getMoreData(DateTime.now());
    }
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        ForumModel lastModel = _itemList.last;
        _getMoreData(lastModel.postedDate);
      }
    });
    super.initState();
  }

  void _getMoreData(DateTime time) async {
    await Provider.of<GeneralProviderData>(context, listen: false).getComments(widget.forumModel, time, 10);
  }

  @override
  Widget build(BuildContext context) {
    _length = context.watch<GeneralProviderData>().forumScreenCommentsList.length;
    _itemList =  context.watch<GeneralProviderData>().forumScreenCommentsList;
    UserModel _currentUser = context.read<GeneralProviderData>().currentUser;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 15)),
            itemCount: _length +1,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index){
              if(_length == 0 || index == _length){
                return context.watch<GeneralProviderData>().isAllCommentsFetched
                    ? SizedBox.shrink()
                    : Spinner();
              }
              ForumModel model = _itemList[index];
              if(index == 0){
                return ForumCard(
                  forumModel: model,
                  cardType: ForumCardTypes.detail,
                );
              }
              return ForumCard(
                forumModel: model,
                cardType: ForumCardTypes.comment,
              );
            },
          ),
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 10),
                    child: BaseShadow(
                      child: TextFormField(
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Comment',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          focusColor: kPrimaryColor,
                          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kPrimaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.5
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                        onSaved: (String value){
                          _comment.content = value;
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: BaseShadow(
                    borderRadius: BorderRadius.circular(15),
                    child: Material(
                      color: kColorGreen,
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          _formKey.currentState.save();
                          if(_comment.content.isNotEmpty){
                            _comment.ownerId = _currentUser.id;
                            _comment.ownerName = _currentUser.nameSurname;
                            _comment.postedDate = DateTime.now();
                            _comment.title = '';
                            _comment.category = widget.forumModel.category;
                            _comment.ownerPhoto = 'profile_${_currentUser.gender.toLowerCase()}.svg';
                            _comment.parentId = widget.forumModel.id;
                            await context.read<GeneralProviderData>().postComment(_comment);
                            _formKey.currentState.reset();
                            _scrollController.jumpTo(1);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent,
                          ),
                          width: 60,
                          height: 50,
                          child: Icon(Icons.send, size: 30, color: Colors.white,),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}
