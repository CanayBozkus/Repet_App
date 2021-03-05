class ForumModel {
  String id;
  String title;
  String content;
  DateTime postedDate;
  String ownerId;
  String ownerPhoto;
  int likeCount;
  String contentType;
  String parentId;
  List likedBy = [];

}