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
  String ownerName;
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
      'owner_name': this.ownerName,
    });
  }

  static Future<List<ForumModel>> getPostPaginatedWithDateTime(DateTime time, int limit) async {
    QuerySnapshot dataListRaw = await FirebaseFirestore.instance.collection('ForumModel').orderBy('posted_date', descending: true).where('posted_date', isLessThan: time).limit(limit).get();
    List<QueryDocumentSnapshot> dataList = dataListRaw.docs;
    List<ForumModel> forumInstanceList = [];
    dataList.forEach((element) {
      ForumModel forumInstance = ForumModel();
      Map<String, dynamic> data = element.data();
      forumInstance.title = data['title'];
      forumInstance.content = data['content'];
      forumInstance.category = kForumCategoryTitlesReverse[data['category']];
      forumInstance.postedDate = data['posted_date'].toDate();
      forumInstance.likeCount = data['like_count'];
      forumInstance.likedBy = data['liked_by'];
      forumInstance.parentId = data['parent_id'];
      forumInstance.ownerPhoto = data['owner_photo'];
      forumInstance.ownerName = data['owner_name'] ?? 'no name';
      forumInstanceList.add(forumInstance);
    });
    return forumInstanceList;
  }
}