import 'package:flutter/material.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/general_provider_data.dart';

class ForumCard extends StatelessWidget {
  ForumCard({@required this.forumModel});
  final ForumModel forumModel;
  @override
  Widget build(BuildContext context) {
    String userId = context.read<GeneralProviderData>().currentUser.id;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: BaseShadow(
        child: Container(
          height: 150,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Container(
                width: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SvgPicture.asset('assets/icons/${forumModel.ownerPhoto}', height: 70,),
                    Text(forumModel.ownerName,),
                    BaseShadow(
                      child: Container(
                        width: 90,
                        height: 24,
                        alignment: Alignment.center,
                        color: Color(0xff54ac14),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        forumModel.title,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800
                        ),
                      ),
                    ),
                    Text(
                      forumModel.content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(),
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
            ],
          ),
        ),
      ),
    );
  }
}