import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/models/calendar_model.dart';

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
  List pets;
  String calendarId;
  CalendarModel calendar;
  FirebaseAuth _auth;
  FirebaseFirestore _fireStore;

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
          'pets': [],
          'calendar_ıd': await CalendarModel.createCalendar(newUser.user.uid),
        });

        await FirebaseAuth.instance.signOut();
        return true;
      }
      return false;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> getUserData() async {
    if(FirebaseAuth.instance.currentUser != null){
      final user = await _fireStore.collection('UserModel').doc( _auth.currentUser.uid).get();
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

  void addPet(){

  }
}