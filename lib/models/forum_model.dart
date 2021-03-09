import 'package:repetapp/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForumModel {
  ForumModel(){
    _fireStore = FirebaseFirestore.instance;
  }
  String id;
  String title;
  String content;
  DateTime postedDate;
  String ownerId;
  String ownerPhoto;
  int likeCount = 0;
  ForumCategories category = ForumCategories.food;
  String parentId;
  List likedBy = [];
  FirebaseFirestore _fireStore;

  Future<void> post() async {
    DocumentReference newPost =  _fireStore.collection('ForumModel').doc();
    await newPost.set({
      'title': this.title,
      'content': this.content,
      'posted_date': this.postedDate,
      'owener_id': this.ownerId,
      'owner_photo': this.ownerPhoto,
      'like_count': this.likeCount,
      'parent_id': this.parentId,
      'category': kForumCategoryTitles[this.category],
      'liked_by': this.likedBy,
    });
  }

  static Future<void> getPostPaginatedWithDateTime(DateTime time, int limit) async {
    QuerySnapshot dataList = await FirebaseFirestore.instance.collection('ForumModel').orderBy('posted_date', descending: true).limit(limit).get();
    print(dataList);
  }
}