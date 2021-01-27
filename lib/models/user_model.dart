import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/models/pet_model.dart';

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
  String gender;
  List addresses;
  List pets = [];
  String calendarId;
  CalendarModel calendar;
  FirebaseAuth _auth;
  FirebaseFirestore _fireStore;
  bool newsSetterConfirmation = true;

  Future<bool> createUser() async {
    try{
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(newUser != null){
        DocumentReference newDocument = await _fireStore.collection('UserModel').doc(newUser.user.uid);
        await newDocument.set({
          'name_surname': nameSurname,
          'age': age,
          'phone_number': phoneNumber,
          'gender': gender,
          'id': newUser.user.uid,
          'addresses': [],
          'pets': pets,
          'calendar_id': await CalendarModel.createCalendar(newUser.user.uid),
        });
        this.id = newUser.user.uid;
        return true;
      }
      return false;
    }
    catch(e){
      print(e);
      await _deleteUser();
      return false;
    }
  }

  Future<bool> getUserData() async {
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

      return true;
    }
    return false;
  }

  void getCalendarData() async {
    calendar = CalendarModel();
    await calendar.getCalendarData(id);
  }

  Future<bool> addPet(PetModel newPet, bool isUserRegistration) async {
    try {
      newPet.id = this.id + newPet.name;
      newPet.ownerId = this.id;
      bool result = await newPet.createPet();
      if(result){
        this.pets.add(newPet.id);
        DocumentReference userModel = await _fireStore.collection('UserModel').doc(this.id);
        userModel.update({
          'pets': this.pets,
        });
      }
      else {
        isUserRegistration ? await _deleteUser() : null;
      }
      return result;
    }

    catch(e){
      print(e);
      isUserRegistration ? await _deleteUser() : null;
      return false;
    }
  }

  void signOut() async {
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
}