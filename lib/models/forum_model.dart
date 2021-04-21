import 'package:repetapp/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForumModel {
  ForumModel() {
    _fireStore = FirebaseFirestore.instance;
  }
  /*
    Each ForumModel is a model for representing a thread(post) or a comment in the forum or blog.
    
    Parameter definitions:
      String id: ID of this thread/comment.
      String title: Title that is shown in the preview of this thread/comment.
      String content: Content of this thread/comment.
      DateTime postedDate: Date of publication.
      String ownerId: UID of the creator of this thread/comment.
      String ownerName: Name of the creator of this thread/comment.
      String ownerPhoto: Profile picture of the creator of this thread/comment.
      int likeCount: Shows how many likes did this thread/comment get. initially equals to zero.
      ForumCategories category: Enum object for classifying the category of this thread/comment. initially equals to ForumCategories.food
      String parentId: If this model represents a comment, parentId is the id of the thread that this comment belongs to. Otherwise it is null.
      List likedBy: List of UID's which belongs to the users who liked this thread/comment. Initially equals to an empty list.
      String screen: Indicates that in which screen should this model be displayed.
  */

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
  String screen = 'forum';
  FirebaseFirestore _fireStore;

  Future<void> post() async {
    /*
      Future<void> postFuture = post()

      Inserts the forum thread/comment represented by this model to the cloud firestore

      Parameters:
        none
      Return
        postFuture: A future which resolves after inserting this ForumModel to 
        the cloud firestore. Yields to nothing.

    */
    DocumentReference newPost = _fireStore.collection('ForumModel').doc();
    await newPost.set({
      'title': this.title,
      'content': this.content,
      'posted_date': this.postedDate,
      'owner_id': this.ownerId,
      'owner_photo': this.ownerPhoto,
      'like_count': this.likeCount,
      'parent_id': this.parentId,
      'category': kForumCategoryTitles[this.category],
      'liked_by': this.likedBy,
      'screen': this.screen,
    });
  }

  static Future<List<ForumModel>> getPostPaginatedWithDateTime(
      DateTime time, int limit, bool isForum) async {
    /*
      Future<List<ForumModel>> postsListFuture = 
        getPostPaginatedWithDateTime(DateTime time, int limit, bool isForum)

      Gets at most [limit] posts that are posted before [time] in descending order. 
      
      Parameters:
        DateTime time: Upper-bound for the time limit.
        int limit: Maximum amount of posts that should be retrieved.
        bool isForum: indicates that whether this function is called from ForumScreen or not.
      
      Return
        Future<List<ForumModel>> postsListFuture: A future that resolves
        into a list of ForumModels. Contains [limit] posts which comes before 
        [time]. 

    */

    QuerySnapshot dataListRaw = await FirebaseFirestore.instance
        .collection('ForumModel')
        .orderBy('posted_date', descending: true)
        .where('screen', isEqualTo: isForum ? 'forum' : 'blog')
        .where('parent_id', isNull: true)
        .where('posted_date', isLessThan: time)
        .limit(limit)
        .get();

    List<ForumModel> data =
        ForumModel.createForumModelListFromQuerySnapshot(dataListRaw);

    data = await ForumModel.getOwnerData(data);

    return data;
  }

  Future<void> likeOrDislike(String userId) async {
    /*
      Future<void> likeOrDislike_future =  likeOrDislike(String userId)

      Like feature for posts. If the post is currently liked by the
      client, function call removes the like by the client and vice versa.
      
      Parameters:
        String userId: Firebase UID of the client.
      Return
        Future<void> likeOrDislike_future: A future that resolves when the updated
        data is inserted into cloud firestore. Yields nothing.

    */

    if (this.likedBy.contains(userId)) {
      this.likedBy.remove(userId);
      this.likeCount -= 1;
    } else {
      this.likedBy.add(userId);
      this.likeCount += 1;
    }

    DocumentReference newPost =
        _fireStore.collection('ForumModel').doc(this.id);
    await newPost.update({
      'liked_by': this.likedBy,
      'like_count': this.likeCount,
    });
  }

  Future<List<ForumModel>> getComments(DateTime time, int limit) async {
    /*
      Future<List<ForumModel>> commentsListFuture = 
        getComments(DateTime time, int limit)

      Retrieves at most [limit] comments poster after [time] that are related with 
      this ForumModel.
      
      Parameters:
        DateTime time: Lower-bound for the time limit.
        int limit: Maximum amount of posts that should be retrieved.

      Return
        Future<List<ForumModel>> commentsListFuture: A future that resolves
        into a list of ForumModels. Contains [limit] comments that are posted
        after [time]. 

    */

    QuerySnapshot dataListRaw = await FirebaseFirestore.instance
        .collection('ForumModel')
        .orderBy('posted_date', descending: false)
        .where('parent_id', isEqualTo: this.id)
        .where('posted_date', isGreaterThan: time)
        .limit(limit)
        .get();
    List<ForumModel> data =
        ForumModel.createForumModelListFromQuerySnapshot(dataListRaw);

    data = await ForumModel.getOwnerData(data);

    return data;
  }

  static Future<List<ForumModel>> refreshDataList(
      DateTime time, bool isForum) async {
    /*
      Future<List<ForumModel>> postsRefreshFuture = 
        refreshDataList(DateTime time, bool isForum)

      Retrieves all the posts that are posted after [time].
      
      Parameters:
        DateTime time: Lower-bound for the time limit.
        bool isForum: indicates that whether this function is called from ForumScreen or not.

      Return
        Future<List<ForumModel>> commentsListFuture: A future that resolves
        into a list of ForumModels. Contains all the posts that are posted
        after [time]. 

    */
    QuerySnapshot dataListRaw = await FirebaseFirestore.instance
        .collection('ForumModel')
        .orderBy('posted_date', descending: true)
        .where('screen', isEqualTo: isForum ? 'forum' : 'blog')
        .where('parent_id', isNull: true)
        .where('posted_date', isGreaterThan: time)
        .get();
    List<ForumModel> data =
        ForumModel.createForumModelListFromQuerySnapshot(dataListRaw);
    return data;
  }

  static List<ForumModel> createForumModelListFromQuerySnapshot(
      QuerySnapshot dataListRaw) {
    /*
      List<ForumModel> dataList = 
        createForumModelListFromQuerySnapshot(QuerySnapshot dataListRaw)

      Gets all the ForumModels in a QuerySnapshot and puts them into a list.

      Parameters:
        QuerySnapshot dataListRaw: QuerySnapshot that is retrieved after sending
        a get query to the cloud firebase. dataListRaw.docs[i].data() contains
        the data of the ForumModel corresponds to the index [i] in the format of
        Map<String, dynamic>.
      
      Return:
        List<ForumModel> dataList: Result of converting each ForumModel data 
        that has the Map<String, dynamic> format into ForumModel object.
    */
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
      forumInstance.ownerId = data['owner_id'];
      forumInstance.id = element.id;
      forumInstanceList.add(forumInstance);
    });
    return forumInstanceList;
  }

  static Future<List<ForumModel>> getOwnerData(List<ForumModel> data) async {
    for(ForumModel model in data){
      DocumentSnapshot userDataRaw = await FirebaseFirestore.instance
          .collection('UserModel')
          .doc(model.ownerId)
          .get();
      Map userData = userDataRaw.data();
      model.ownerName = userData['name_surname'];
    }
    return data;
  }
}
