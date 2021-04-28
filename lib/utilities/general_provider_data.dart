import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:repetapp/l10n/l10n.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/models/remainder_field_model.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/services/database.dart';

import 'constants.dart';

class GeneralProviderData with ChangeNotifier {
  UserModel currentUser = UserModel();
  Map<String, PetModel> pets;
  String currentShownPetIndex;
  bool isMainScreenDataFetched = false;
  CalendarModel calendar = CalendarModel();
  int nextNotificationId;

  List<ForumModel> forumScreenForumDataList = [];
  bool isAllForumScreenForumDataFetched = false;

  List<ForumModel> forumScreenBlogDataList = [];
  bool isAllForumScreenBlogDataFetched = false;
  List<ForumCategories> blogScreenFilter = ForumCategories.values.toList();

  List<ForumModel> forumScreenCommentsList = [];
  bool isAllCommentsFetched = false;

  UserModel newUser;

  Locale _locale;

  Locale get locale => _locale;

  void setLocale(Locale locale){
    if(!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }

  // Wrapper function for getting all the necessary data for the main screen.
  Future<void> getMainScreenData() async {
    await this
        .getUserData(); // Write the data of the current client into this.currentUser
    await this.getPets(); //  Get all the pets associated with this.currentUser
    this.isMainScreenDataFetched = true;
    this._getNextNotificationId();
    notifyListeners();
  }

  // Wrapper function for getting all the user data of currently authenticated user.
  Future<void> getUserData() async {
    await currentUser.getUserData(); // Write all the data into this.currentUser
    notifyListeners();
  }

  // Wrapper function for getting all the pets' ids of this.currentUser.
  Future<void> getPets() async {
    pets = await currentUser.getPets();
    currentShownPetIndex = currentUser.pets[0];
    notifyListeners();
  }

  // Wrapper function for getting the calendar data of currently authenticated client.
  Future<void> getCalendarData() async {
    calendar.getLocalCalendarData();
  }

  void _getNextNotificationId() {
    this.nextNotificationId = databaseManager.getNextNotificationId();
  }

  Future<void> addNewRemainder(
      PetModel pet, Remainders remainder, DateTime time, bool isActive) async {
    /*
      Wrapper function for adding a new reminder and updating the UI by notifying
      the listeners.

      Parameters:
        PetModel pet: PetModel that represents a specific pet of the user.
        Remainders remainder: Reminder category.
        DateTime time: A Datetime object that specifies the time of the reminder.
        int notificationId: ID that will be possesed by newly created notification.
        bool isActive: Indicates that if this reminder is enabled or not.
      
      Returns:
        Future<void>: A future that resolves after routine is added. Yields
        nothing.

    */
    await currentUser.addRemainder(
        pet, remainder, time, nextNotificationId, isActive);
    nextNotificationId++;
    notifyListeners();
  }

  Future<void> removeReminder(
      PetModel pet, Remainders reminder, int reminderModelId) async {
    await currentUser.removeReminder(pet, reminder, reminderModelId);
    notifyListeners();
  }

  Future<void> updateReminder(
    PetModel pet,
    Remainders reminder,
    int reminderModelId,
    Map<String, dynamic> reminderData,
  ) async {
    await currentUser.updateReminder(
        pet, reminder, reminderModelId, reminderData);
    notifyListeners();
  }

  Future<void> updateRemainderStatus(
      PetModel pet,
      RemainderFieldModel remainderFieldModel,
      Remainders remainder,
      bool newStatus) async {
    /*
      Function for updating a existing reminder and updating the UI by notifying
      the listeners.

      Parameters:
        PetModel pet: PetModel that represents a specific pet of the user.
        Remainders remainder: Reminder category.
        RemainderFieldModel remainderField: Model of the reminder.
        bool newStatus: The status that will be replaced with the old one.
      
      Returns:
        Future<void>: A future that resolves after routine is updated. Yields
        nothing.
    */
    await currentUser.updateRemainderStatus(
        pet, remainderFieldModel, remainder, newStatus);
    notifyListeners();
  }

  Future<void> cancelRemainder(PetModel pet, id, name) async {
    await currentUser.cancelRemainder(pet, id, name);
    notifyListeners();
  }

  // Function for making this.currentUser log out. This function unauthenticates
  // this.currentUser and clears all the associated data which is stored in [this].
  Future<void> signOut() async {
    await currentUser.signOut();
    currentUser = UserModel();
    pets = {};
    currentShownPetIndex = '';
    isMainScreenDataFetched = false;
    notifyListeners();
  }

  // Function for updating a single pet in this.pets.
  void updatePetsMap(PetModel pet) {
    this.pets[pet.id] = pet;
    notifyListeners();
  }

  // Function for changing the currently displayed pet in the screen.
  void changeCurrentPet(String petId) {
    currentShownPetIndex = petId;
    notifyListeners();
  }

  // Wrapper function for adding a new event to this.calendar
  void addEvent(String event, DateTime date) {
    calendar.addEvent(event, date);
    notifyListeners();
  }

  void removeEvent(String event, DateTime key) {
    calendar.removeEvent(event, key);
    notifyListeners();
  }

  void updateEvent({String prevEvent, String newEvent, DateTime newDate}) {
    calendar.updateEvent(
      newDate: newDate,
      newEvent: newEvent,
      prevEvent: prevEvent,
    );
    notifyListeners();
  }

  // Wrapper function for updating an event in this.calendar
  void updateEventStatus(DateTime date, bool status) {
    calendar.updateStatus(date, status);
    notifyListeners();
  }

  // Function for updating the data of the currently displayed pet.
  // Parameter [data] contains all the fields that should be uploaded and the
  // new values that will be inserted.
  Future<bool> updatePetData(Map<String, dynamic> data) async {
    bool result = await pets[currentShownPetIndex].updateData(data);
    notifyListeners();
    return result;
  }

  // Function for updating the data of this.currentUser.
  // Parameter [data] contains all the fields that should be uploaded and the
  // new values that will be inserted.
  Future<bool> updatePersonalData(Map<String, dynamic> data) async {
    bool result = await currentUser.updateData(data);
    notifyListeners();
    return result;
  }

  // Function for updating the credentials of this.currentUser
  // Will return a future that yields the error message, if there is any.
  // Otherwise, it will yield null.
  Future<String> updateEmail(email, password) async {
    String result = await currentUser.updateEmail(email, password);
    notifyListeners();
    return result;
  }

  Future<void> getForumScreenForumData(DateTime time, int limit) async {
    /*
      Wrapper function for getting the data associated with forum screen.
      Gets at most [limit] posts that are posted before [time] in descending order.
      
      Parameters:
        DateTime time: Upper-bound for the time limit.
        int limit: Maximum amount of posts that should be retrieved.
      
      Return
        Future<void>  A future that resolves after data is retrieved and set. Yields
        nothing.
    */
    List<ForumModel> newData =
        await ForumModel.getPostPaginatedWithDateTime(time, limit, true);
    if (newData.isEmpty) {
      isAllForumScreenForumDataFetched = true;
    } else {
      // Concatenate new posts with already fetched ones.
      forumScreenForumDataList = [...forumScreenForumDataList, ...newData];
      // Is there any posts left to get for the forum screen.
      newData.length < limit
          ? isAllForumScreenForumDataFetched =
              true // There is none, so all the posts are fetched.
          : isAllForumScreenForumDataFetched =
              false; // There is, so there is still more posts that can be fetched.
    }
    notifyListeners();
  }

  // Wrapper function for this.currentUser to like or dislike a certain post [model].
  Future<void> likeOrDislikeForumPost(ForumModel model, String userId) async {
    await model.likeOrDislike(userId);
    notifyListeners();
  }

  Future<void> getForumScreenBlogData(DateTime time, int limit) async {
    /*
      Wrapper function for getting the data associated with blog screen.
      Gets at most [limit] posts that are posted before [time] in descending order.
      
      Parameters:
        DateTime time: Upper-bound for the time limit.
        int limit: Maximum amount of posts that should be retrieved.
      
      Return
        Future<void>  A future that resolves after data is retrieved and set. Yields
        nothing.
    */
    List<ForumModel> newData =
        await ForumModel.getPostPaginatedWithDateTime(time, limit, false);
    if (newData.isEmpty) {
      isAllForumScreenBlogDataFetched = true;
    } else {
      // Concatenate new posts with already fetched ones.
      forumScreenBlogDataList = [...forumScreenBlogDataList, ...newData];
      // Is there any posts left to get for the blog screen.
      newData.length < limit
          ? isAllForumScreenBlogDataFetched =
              true // There is not, so all the posts are fetched.
          : isAllForumScreenBlogDataFetched =
              false; // There is, so there is still more posts that can be fetched.
    }
    notifyListeners();
  }

  void filterForumScreenBlogDataListView(ForumCategories category) {
    /*
      Function for filtering and un-filtering the blog screen. Each time this
      function is called, it switches the state of the blog screen between two
      states:
      
      Unfiltered state: Posts from all categories are shown.
      Filtered state: Posts only from type [category] are shown.  
    */

    // If the blog screen is in filtered state
    if (blogScreenFilter.length == 1) {
      // If same type of filtering is being requested
      blogScreenFilter.contains(category)
          ? blogScreenFilter =
              ForumCategories.values.toList() // Switch to unfiltered state.
          : blogScreenFilter = [
              category
            ]; // Stay in filtered mode, but now only show posts from this newly requested [category]
    } else {
      // If blog screen is in unfiltered state
      blogScreenFilter = [
        category
      ]; // Switch it to filtered state and filter by [category].
    }
    notifyListeners();
  }

  void initializeCommentVariables() {
    isAllCommentsFetched = false;
    forumScreenCommentsList = [];
  }

  Future<void> getComments(
      ForumModel forumModel, DateTime time, int limit) async {
    /*
      Wrapper function for getting all the comments under a certain forum post:
      [forumModel]. Gets at most [limit] posts that are posted after [time] in
      descending order.
      
      Parameters:
        ForumModel forumModel: Parent of the co
        DateTime time: Upper-bound for the time limit.
        int limit: Maximum amount of posts that should be retrieved.
      
      Return
        Future<void>  A future that resolves after data is retrieved and set. 
        Yields nothing.
    */
    List<ForumModel> newData = await forumModel.getComments(time, limit);

    if (newData.isEmpty) {
      isAllCommentsFetched = true;
    } else {
      // Concatenate new comments with already fetched ones.
      forumScreenCommentsList = [...forumScreenCommentsList, ...newData];
      // Is there any comments left to fetch ?
      newData.length < limit
          ? isAllCommentsFetched =
              true // There is not, so all the comments are fetched.
          : isAllCommentsFetched =
              false; // There is, so there is still more comments that can be fetched.
    }
    notifyListeners();
  }

  void addItemToCommentsList(ForumModel model) {
    forumScreenCommentsList.add(model);
  }

  // Wrapper function for posting a [comment].
  Future<void> postComment(ForumModel comment) async {
    await comment.post();
    forumScreenCommentsList.add(comment);
    notifyListeners();
  }

  // Wrapper function for reloading the contents of forum screen.
  Future<void> refreshForumScreenForumData() async {
    // Get all the posts that are posted after most recently posted one that is
    // currently stored.
    List<ForumModel> newData = await ForumModel.refreshDataList(
        forumScreenForumDataList.first.postedDate, true);
    if (newData.isNotEmpty) {
      // insert them at the beginning since they are most recently posted ones now.
      forumScreenForumDataList = [...newData, ...forumScreenForumDataList];
    }
    notifyListeners();
  }

  // Wrapper function for posting a forum post/thread.
  Future<void> postToForum(ForumModel model) async {
    await model.post();
    forumScreenForumDataList.insert(0, model);
    notifyListeners();
  }
}
