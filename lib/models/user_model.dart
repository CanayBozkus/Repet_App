import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel(){
    _auth = FirebaseAuth.instance;
    _fireStore = FirebaseFirestore.instance;
  }

  String email;
  String password;
  String nameSurname;
  String age;
  String phoneNumber;
  String gender = 'Female';
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
}