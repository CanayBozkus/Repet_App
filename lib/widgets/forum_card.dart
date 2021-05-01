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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForumCard extends StatelessWidget {
  ForumCard({@required this.forumModel, @required this.cardType});
  final ForumModel forumModel;
  final ForumCardTypes cardType;

  String getTitle(AppLocalizations localized){
    switch(forumModel.category){
      case ForumCategories.care: return localized.care;
      case ForumCategories.food: return localized.food;
      case ForumCategories.social: return localized.social;
      case ForumCategories.training: return localized.training;
      default: return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    String userId = context.read<GeneralProviderData>().currentUser.id;
    AppLocalizations localized = AppLocalizations.of(context);
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
              height: cardType == ForumCardTypes.summary ? 210 : null,
              padding: EdgeInsets.symmetric(vertical: cardType == ForumCardTypes.summary ? 8 : 12, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.topRight,
                            child: Text(
                              '${forumModel.postedDate.getHourAndMinuteString()}, ${forumModel.postedDate.day}.${forumModel.postedDate.month}.${forumModel.postedDate.year}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          cardType != ForumCardTypes.comment ? BaseShadow(
                            child: Container(
                              width: 90,
                              height: 24,
                              alignment: Alignment.center,
                              color: kBlogPageCategoryColors[forumModel.category],
                              child: Text(
                                getTitle(localized),
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ) : SizedBox.shrink(),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      cardType != ForumCardTypes.comment ? Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            forumModel.title,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800
                                            ),
                                            maxLines: cardType == ForumCardTypes.summary ? 2 : null,
                                            overflow: cardType == ForumCardTypes.summary ? TextOverflow.ellipsis : null,
                                          ),
                                        ),
                                      ) : SizedBox.shrink(),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      forumModel.content,
                                      maxLines: cardType == ForumCardTypes.summary ? 3 : null,
                                      overflow: cardType == ForumCardTypes.summary ? TextOverflow.ellipsis : null,
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            SvgPicture.network('$kImageRepositoryUrl${forumModel.ownerPhoto}', height: 25,),
                            SizedBox(width: 10,),
                            Text(
                              forumModel.ownerName,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ClipOval(
                              child: Material(
                                shape: CircleBorder(),
                                color: Colors.transparent,
                                child: InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      forumModel.likedBy.contains(userId) ? Icons.favorite : Icons.favorite_border,
                                      color: Color(0xffff3636),
                                    ),
                                  ),
                                  onTap: () async {
                                    await context.read<GeneralProviderData>().likeOrDislikeForumPost(forumModel, userId);
                                  },

                                ),
                              ),
                            ),
                            Text(forumModel.likeCount.toString()),
                          ],
                        ),
                      ),
                    ],
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

/*
Container(
                        width: 90,
                        child: Column(
                          mainAxisAlignment: cardType == ForumCardTypes.summary ? MainAxisAlignment.spaceAround : MainAxisAlignment.start,
                          children: [
                            SvgPicture.network('$kImageRepositoryUrl${forumModel.ownerPhoto}', height: 70,),
                            SizedBox(height: 10,),
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
 */