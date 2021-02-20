import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/models/hive_models/hive_user_model.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/services/notification_plugin.dart';
import 'package:repetapp/services/database.dart';

class UserModel {
  UserModel({this.email, this.age, this.phoneNumber, this.gender = 'Female', this.nameSurname}){
    _auth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
  }

  String id;
  String email;
  String password;
  String nameSurname;
  int age;
  int phoneNumber;
  String gender = 'Female';
  List addresses;
  List pets = [];
  String calendarId;
  CalendarModel calendar;
  FirebaseAuth _auth;
  FirebaseFirestore _fireStore;
  bool newsSetterConfirmation = true;
  Map currentNotifications = {};

  Future<bool> createUser() async {
    bool isCloudDataCreated = await this.createUserForCloud();
    if(isCloudDataCreated){
      bool isLocalDataCreated = this.createUserForLocal();
      return isLocalDataCreated;
    }
    return isCloudDataCreated;
  }

  Future<bool> createUserForCloud() async {
    try{
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(newUser != null) {
        DocumentReference newDocument = await _fireStore.collection('UserModel')
            .doc(newUser.user.uid);
        await newDocument.set({
          'name_surname': nameSurname,
          'age': age,
          'phone_number': phoneNumber,
          'gender': gender,
          'id': newUser.user.uid,
          'addresses': [],
          'pets': pets,
          'newsSetterConfirmation': newsSetterConfirmation,
          'calendar_id': await CalendarModel.createCalendar(newUser.user.uid),
          'current_notifications': currentNotifications,
        });
        this.id = newUser.user.uid;
        return true;
      }
      await _deleteUser();
      return false;
    }
    catch(e){
      print(e);
      await _deleteUser();
      return false;
    }
  }

  bool createUserForLocal(){
    HiveUserModel localUser = HiveUserModel(
      id: this.id,
      nameSurname: this.nameSurname,
      gender: this.gender,
      phoneNumber: this.phoneNumber,
      age: this.age,
      pets: this.pets,
      addresses: this.addresses,
      calendarId: this.calendarId,
      email: this.email,
      currentNotifications: this.currentNotifications,
    );
    databaseManager.addData(model: 'userModel', data: localUser);
    return true;
  }

  //TODO: static method haline getir, return olarak UserModel() döndür.
  Future<bool> getUserData() async {
    bool isLocalDataExist = this.getLocalUserData();
    if(!isLocalDataExist){
      bool isCloudDataExist = await this.getCloudUserData();
      return isCloudDataExist;
    }
    return isLocalDataExist;
  }

  bool getLocalUserData(){
    HiveUserModel localUser = databaseManager.getLocalUserData(_auth.currentUser.uid);

    if(localUser != null){
      nameSurname = localUser.nameSurname;
      gender = localUser.gender;
      phoneNumber = localUser.phoneNumber;
      age = localUser.age;
      pets = localUser.pets;
      addresses = localUser.addresses;
      calendarId = localUser.calendarId;
      id = _auth.currentUser.uid;
      email = _auth.currentUser.email;
      currentNotifications = localUser.currentNotifications;
      return true;
    }
    return false;
  }

  Future<bool> getCloudUserData() async {
    if(FirebaseAuth.instance.currentUser != null){
      DocumentSnapshot user = await _fireStore.collection('UserModel').doc( _auth.currentUser.uid).get();
      Map userData = user.data();
      nameSurname = userData['name_surname'];
      gender = userData['gender'];
      phoneNumber = userData['phone_number'];
      age = userData['age'];
      pets = userData['pets'];
      addresses = userData['addresses'];
      calendarId = userData['calendar_id'];
      id = _auth.currentUser.uid;
      email = _auth.currentUser.email;
      currentNotifications = userData['current_notifications'];

      HiveUserModel localUser = HiveUserModel(
        id: this.id,
        nameSurname: this.nameSurname,
        gender: this.gender,
        phoneNumber: this.phoneNumber,
        age: this.age,
        pets: this.pets,
        addresses: this.addresses,
        calendarId: this.calendarId,
        email: this.email,
        currentNotifications: this.currentNotifications,
      );
      databaseManager.addData(model: 'userModel', data: localUser);
      return true;
    }
    return false;
  }

  Future<bool> addPet(PetModel newPet, bool isUserRegistration) async {
    //TODO: üzerinden yeniden geçmek ve hata senaryolarını düzeltmek gerekli
    newPet.id = (this.id + newPet.name).replaceAll(' ', '');
    newPet.ownerId = this.id;
    bool result = await newPet.createPet();
    if(result){
      this.pets.add(newPet.id);
      bool isLocalDataUpdated = this.updateLocalPetList();
      bool isCloudDataUpdated = await this.updateCloudPetList();
      
      return isLocalDataUpdated || isCloudDataUpdated;
    }
    isUserRegistration ? await _deleteUser() : null;
    return false;
  }
  
  Future<bool> updateCloudPetList() async {
    try{
      DocumentReference userModel = await _fireStore.collection('UserModel').doc(this.id);
      await userModel.update({
        'pets': this.pets,
      });
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }
  
  bool updateLocalPetList(){
    return databaseManager.updatePetList(id, pets);
  }
  
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _deleteUser() async {
    User user = _auth.currentUser;
    await user.delete();
    await _fireStore.collection('UserModel').doc(user.uid).delete();
    for(int i=0; i<pets.length; i++){
      //TODO: PetModel.deletePet() yazılacak ve böylelikle pet'e bağlı olan collectionlar da silinecek.
      await _fireStore.collection('PetModel').doc(pets[i]).delete();
    }
    await _fireStore.collection('CalendarModel').doc(user.uid).delete();
  }

  Future<Map<String,PetModel>> getPets() async {
    Map<String,PetModel> petModels = {};
    for(int i=0; i<pets.length; i++){
      PetModel pet = PetModel();
      bool result = await pet.getPetData(pets[i]);
      petModels[pets[i]] = result ? pet : null;
    }
    return petModels;
  }

  void setNotificationSettings(){
    notificationPlugin.setListenerForLowerVersions((){});
    notificationPlugin.setOnNotificationClick((String payload){
    });
  }

  Future<void> addRemainder(PetModel pet, String routineName, DateTime time) async {
    String idName = pet.name.replaceAll(' ', '') + routineName + currentNotifications.length.toString();
    bool result = await pet.addRoutine(routineName, time, currentNotifications.length, idName);
    if(result){
      updateCurrentNotifications(idName);
    }
  }

  void updateCurrentNotifications(String id){
    currentNotifications[id] = currentNotifications.length;
    databaseManager.updateCurrentNotifications(this.currentNotifications, this.id);
  }

  Future<void> reActivateRemainder(PetModel pet, String routineName, DateTime time, idName) async {
    bool result = await pet.addRoutine(routineName, time, currentNotifications[idName], idName);
  }

  Future<void> cancelRemainder(PetModel pet, id, routineName) async {
    await pet.cancelRoutine(currentNotifications[id], routineName);
  }
}