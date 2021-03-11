import 'package:flutter/foundation.dart';
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

  Future<void> getMainScreenData() async {
    await this.getUserData();
    await this.getPets();
    this.isMainScreenDataFetched = true;
    this._getNextNotificationId();
    notifyListeners();
  }

  Future<void> getUserData() async {
    await currentUser.getUserData();
    notifyListeners();
  }

  Future<void> getPets() async {
    pets = await currentUser.getPets();
    currentShownPetIndex = currentUser.pets[0];
    notifyListeners();
  }

  Future<void> getCalendarData() async {
    calendar.getLocalCalendarData();
  }

  void _getNextNotificationId(){
    this.nextNotificationId = databaseManager.getNextNotificationId();
  }

  Future<void> addNewRemainder(PetModel pet, Remainders remainder, DateTime time, bool isActive) async {
    await currentUser.addRemainder(pet, remainder, time, nextNotificationId, isActive);
    nextNotificationId++;
    notifyListeners();
  }

  Future<void> updateRemainderStatus(PetModel pet, RemainderFieldModel remainderFieldModel, Remainders remainder, bool newStatus) async {
    await currentUser.updateRemainderStatus(pet, remainderFieldModel, remainder, newStatus);
    notifyListeners();
  }

  Future<void> cancelRemainder(PetModel pet, id, name) async {
    await currentUser.cancelRemainder(pet, id, name);
    notifyListeners();
  }

  Future<void> signOut() async {
    await currentUser.signOut();
    currentUser = UserModel();
    pets = {};
    currentShownPetIndex = '';
    isMainScreenDataFetched = false;
    notifyListeners();
  }

  void updatePetsMap(PetModel pet){
    this.pets[pet.id] = pet;
    notifyListeners();
  }

  void changeCurrentPet(String petId){
    currentShownPetIndex = petId;
    notifyListeners();
  }

  void addEvent(String event, DateTime date){
    calendar.addEvent(event, date);
    notifyListeners();
  }

  void updateEventStatus(DateTime date, bool status){
    calendar.updateStatus(date, status);
    notifyListeners();
  }

  Future<bool> updatePetData(Map<String, dynamic> data) async {
    bool result = await pets[currentShownPetIndex].updateData(data);
    notifyListeners();
    return result;
  }

  Future<bool> updatePersonalData(Map<String, dynamic> data) async {
    bool result = await currentUser.updateData(data);
    notifyListeners();
    return result;
  }

  Future<String> updateEmail(email, password) async {
    String result = await currentUser.updateEmail(email, password);
    notifyListeners();
    return result;
  }

  Future<void> getForumScreenForumData(DateTime time, int limit) async {
    List<ForumModel> newData = await ForumModel.getPostPaginatedWithDateTime(time, limit, true);
    if(newData.isEmpty){
      isAllForumScreenForumDataFetched = true;
    }
    else{
      forumScreenForumDataList = [...forumScreenForumDataList, ...newData];
    }
    notifyListeners();
  }

  Future<void> likeOrDislikeForumPost(ForumModel model, String userId) async {
    await model.likeOrDislike(userId);
    notifyListeners();
  }

  Future<void> getForumScreenBlogData(DateTime time, int limit) async {
    List<ForumModel> newData = await ForumModel.getPostPaginatedWithDateTime(time, limit, false);
    if(newData.isEmpty){
      isAllForumScreenBlogDataFetched = true;
    }
    else{
      forumScreenBlogDataList = [...forumScreenBlogDataList, ...newData];
    }
    notifyListeners();
  }

  void filterForumScreenBlogDataListView(ForumCategories category){
    if(blogScreenFilter.length == 1){
      blogScreenFilter.contains(category) ? blogScreenFilter = ForumCategories.values.toList() : blogScreenFilter = [category];
    }
    else {
      blogScreenFilter = [category];
    }
    notifyListeners();
  }
}