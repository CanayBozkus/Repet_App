import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  FirebaseHelper(){
    _fireStore = FirebaseFirestore.instance;
  }

  FirebaseFirestore _fireStore;

  Future<Map> filter(model, List filter) async {
    final data = await _fireStore.collection('UserModel').where(filter[0], ).get();
  }
}