import 'package:cloud_firestore/cloud_firestore.dart';

class PetModel {
  PetModel(){
    _fireStore = FirebaseFirestore.instance;
  }
  
  String id;
  String ownerId;
  String name;
  String catalog;
  String species;
  double weight;
  double height;
  int age;
  List allergies;
  List disabilities;
  List sicknesses;
  List routines;
  int petTrainingModelId;
  FirebaseFirestore _fireStore;
  
  Future<bool> createPet() async {
    try{
      DocumentReference newPet = await _fireStore.collection('PetModel').doc(id);
      await newPet.set({
        'id': id,
        'owner_id': ownerId,
        'name': name,
        'catalog': catalog,
        'species': species,
        'weight': weight,
        'height': height,
        'age': age,
        'allergies': [],
        'disabilities': [],
        'sicknesses': [],
        'routines': [],
        'petTrainingModelId': -1,
      });
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }
}