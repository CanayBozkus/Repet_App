import 'package:flutter/material.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/screens/forum_subscreen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/widgets/view_post_details.dart';
import 'package:repetapp/utilities/extensions.dart';

class ForumCard extends StatelessWidget {
  ForumCard({@required this.forumModel, @required this.cardType});
  final ForumModel forumModel;
  final ForumCardTypes cardType;
  @override
  Widget build(BuildContext context) {
    String userId = context.read<GeneralProviderData>().currentUser.id;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: cardType == ForumCardTypes.summary ? 8 : 0),
      child: BaseShadow(
        child: Material(
          child: InkWell(
            onTap: (){
              cardType == ForumCardTypes.summary ? Navigator.pushNamed(context, ForumSubScreen.routeName, arguments: ViewPostDetails(forumModel: forumModel,)) : null;
            },
            splashColor: cardType == ForumCardTypes.summary ? Theme.of(context).splashColor : Colors.transparent,
            highlightColor: cardType == ForumCardTypes.summary ? Theme.of(context).highlightColor : Colors.transparent,
            child: Container(
              height: cardType == ForumCardTypes.summary ? 150 : null,
              padding: EdgeInsets.symmetric(vertical: cardType == ForumCardTypes.summary ? 8 : 12, horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 90,
                    child: Column(
                      mainAxisAlignment: cardType == ForumCardTypes.summary ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
                      children: [
                        SvgPicture.network('$kImageRepositoryUrl${forumModel.ownerPhoto}', height: 70,),
                        SizedBox(height: 5,),
                        Text(forumModel.ownerName,),
                        SizedBox(height: 5,),
                        BaseShadow(
                          child: Container(
                            width: 90,
                            height: 24,
                            alignment: Alignment.center,
                            color: kBlogPageCategoryColors[forumModel.category],
                            child: Text(
                              kForumCategoryTitles[forumModel.category],
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 124
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              cardType != ForumCardTypes.comment ? Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  forumModel.title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800
                                  ),
                                  maxLines: cardType == ForumCardTypes.summary ? 1 : null,
                                  overflow: cardType == ForumCardTypes.summary ? TextOverflow.ellipsis : null,
                                ),
                              ) : SizedBox.shrink(),
                              cardType != ForumCardTypes.summary ? Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  '${forumModel.postedDate.day}.${forumModel.postedDate.month}.${forumModel.postedDate.year}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500
                                  ),
                                  maxLines: cardType == ForumCardTypes.summary ? 1 : null,
                                  overflow: cardType == ForumCardTypes.summary ? TextOverflow.ellipsis : null,
                                ),
                              ) : SizedBox.shrink(),
                            ],
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              forumModel.content,
                              maxLines: cardType == ForumCardTypes.summary ? 3 : null,
                              overflow: cardType == ForumCardTypes.summary ? TextOverflow.ellipsis : null,
                              style: TextStyle(),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ClipOval(
                                child: Material(
                                  shape: CircleBorder(),
                                  color: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(
                                      forumModel.likedBy.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                      color: Color(0xffff3636),
                                    ),
                                    splashRadius: 30,
                                    onPressed: () async {
                                      await context.read<GeneralProviderData>().likeOrDislikeForumPost(forumModel, userId);
                                    },
                                    padding: EdgeInsets.zero,
                                  ),
                                ),
                              ),
                              Text(forumModel.likeCount.toString()),
                            ],
                          )
                        ],
                      ),
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