import 'package:repetapp/utilities/constants.dart';

class ForumModel {
  String id;
  String title;
  String content;
  DateTime postedDate;
  String ownerId;
  String ownerPhoto;
  int likeCount;
  ForumCategories category = ForumCategories.food;
  String parentId;
  List likedBy = [];

}