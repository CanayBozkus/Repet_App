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
  bool isDog = true; //TODO: isDog şeklinde alımı değiştir
  String species;
  double weight;
  double height;
  int year;
  int month;
  List allergies = [];
  List disabilities = [];
  List sicknesses = [];
  Map routines = {
    'feeding' : {},
    'water': {},
    'walking': {},
    'grooming': {},
    'playing': {},
  };

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

  Future<bool> getPetData(id) async {
    try {
      DocumentSnapshot pet = await _fireStore.collection('PetModel').doc(id).get();
      Map petData = pet.data();
      name = petData['name'];
      ownerId = petData['owner_id'];
      gender = petData['gender'];
      isDog = petData['catalog'] == 'Dog' ? true : false;
      species = petData['species'];
      weight = petData['weight'];
      height = petData['height'];
      year = petData['year'];
      month = petData['month'];
      allergies = petData['allergies'];
      disabilities = petData['disabilities'];
      sicknesses = petData['sicknesses'];
      routines = petData['routines'];
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