import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({this.email, this.age, this.phoneNumber, this.gender, this.nameSurname}){
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
  List pets;
  int callendar;
  FirebaseAuth _auth;
  FirebaseFirestore _fireStore;

  Future<bool> createUser() async {
    try{
      final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(newUser != null){
        await _fireStore.collection('UserModel').add({
          'name_surname': nameSurname,
          'age': age,
          'phone_number': phoneNumber,
          'gender': gender,
          'id': newUser.user.uid,
        });
        return true;
      }
      return false;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  void getUserData() async {
    if(FirebaseAuth.instance.currentUser != null){
      final user = await _fireStore.collection('UserModel').where('id', isEqualTo: _auth.currentUser.uid).get();
      print(user.docs[0].data());
    }

  }
}