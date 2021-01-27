import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/utilities/constants.dart' as constants;

class PetModel {
  PetModel(){
    _fireStore = FirebaseFirestore.instance;
  }
  
  String id;
  String ownerId;
  String name;
  String gender;
  bool isDog = true;
  String species;
  double weight;
  double height;
  int year;
  int month;
  List allergies = [];
  List disabilities = [];
  List sicknesses = [];
  List routines = [];
  int petTrainingModelId;
  FirebaseFirestore _fireStore;
  
  Future<bool> createPet() async {
    try{
      DocumentReference newPet =  _fireStore.collection('PetModel').doc(id);
      await newPet.set({
        'id': id,
        'owner_id': ownerId,
        'name': name,
        'gender': gender,
        'catalog': isDog ? 'Dog' : 'Cat',
        'species': species,
        'weight': weight,
        'height': height,
        'year': year,
        'month': month,
        'allergies': allergies,
        'disabilities': disabilities,
        'sicknesses': sicknesses,
        'routines': routines,
        'petTrainingModelId': -1,
      });
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  List getAllergies(){
    return constants.allergies;
  }

  List getDisabilities(){
    return constants.disabilities;
  }
}