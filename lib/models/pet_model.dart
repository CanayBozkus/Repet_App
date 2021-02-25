import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/models/hive_models/hive_pet_model.dart';
import 'package:repetapp/models/remainder_field_model.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/services/notification_plugin.dart';
import 'package:repetapp/utilities/constants.dart' as constants;
import 'package:repetapp/utilities/extensions.dart';

class PetModel {
  PetModel(){
    _fireStore = FirebaseFirestore.instance;
  }
  
  String id;
  String ownerId;
  String name;
  String gender;
  constants.PetTypes type = constants.PetTypes.dog;
  String species;
  double weight;
  double height;
  int year;
  int month;
  List allergies = [];
  List disabilities = [];
  List sicknesses = [];
  Map routines = { //TODO: routinelerin içinde saat kısmı için string olarak değil datetime olarak tut.
    'feeding' : [],
    'water': [],
    'walking': [],
    'grooming': [],
    'playing': [],
  };

  int petTrainingModelId;
  FirebaseFirestore _fireStore;
  
  Future<bool> createPet() async {
    try{
      this.createPetForCloud();
      this.createPetForLocal();
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future<void> createPetForCloud() async {
    DocumentReference newPet =  _fireStore.collection('PetModel').doc(id);
    await newPet.set({
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'gender': gender,
      'type': constants.petTypeNames[type],
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
  }

  void createPetForLocal(){
    HivePetModel localPetData = HivePetModel(
      id: this.id,
      name: this.name,
      ownerId: this.ownerId,
      gender: this.gender,
      type: constants.petTypeNames[this.type],
      species: this.species,
      weight: this.weight,
      height: this.height,
      year: this.year,
      month: this.month,
      allergies: this.allergies,
      disabilities: this.disabilities,
      sicknesses: this.sicknesses,
      routines: this.routines,
      petTrainingModelId: -1,
    );
    databaseManager.addData(model: 'petModel', data: localPetData);
  }

  Future<bool> getPetData(id) async {
    bool isLocalDataExist = this.getLocalPetData(id);

    if(!isLocalDataExist){
      try {
        bool isCloudDataExist = await this.getCloudPetData(id);
        return isCloudDataExist;
      }
      catch(e){
        print(e);
        return false;
      }
    }
    return isLocalDataExist;
  }

  bool getLocalPetData(String id){
    HivePetModel localPetData = databaseManager.getLocalPet(id);
    if(localPetData != null){
      this.id = id;
      name =localPetData.name;
      ownerId = localPetData.ownerId;
      gender = localPetData.gender;
      type = constants.petTypeNamesReverse[localPetData.type];
      species = localPetData.species;
      weight = localPetData.weight;
      height = localPetData.height;
      year = localPetData.year;
      month = localPetData.month;
      allergies = localPetData.allergies;
      disabilities = localPetData.disabilities;
      sicknesses = localPetData.sicknesses;
      localPetData.routines.keys.map((key){
        routines[key] = localPetData.routines[key].map((e) => RemainderFieldModel.fromMap(e)).toList();
        return true;
      });
      return true;
    }
    return false;
  }

  Future<bool> getCloudPetData(String id) async {
    DocumentSnapshot pet = await _fireStore.collection('PetModel').doc(id).get();
    Map petData = pet.data();
    this.id = id;
    name = petData['name'];
    ownerId = petData['owner_id'];
    gender = petData['gender'];
    type = constants.petTypeNamesReverse[petData['type']];
    species = petData['species'];
    weight = petData['weight'];
    height = petData['height'];
    year = petData['year'];
    month = petData['month'];
    allergies = petData['allergies'];
    disabilities = petData['disabilities'];
    sicknesses = petData['sicknesses'];
    petData['routines'].keys.map((key){
      routines[key] = petData['routines'][key].map((e) => RemainderFieldModel.fromMap(e)).toList();
      return true;
    });

    HivePetModel localPetData = HivePetModel(
      id: this.id,
      name: this.name,
      ownerId: this.ownerId,
      gender: this.gender,
      type: petData['type'],
      species: this.species,
      weight: this.weight,
      height: this.height,
      year: this.year,
      month: this.month,
      allergies: this.allergies,
      disabilities: this.disabilities,
      sicknesses: this.sicknesses,
      routines: petData['routines'],
    );
    databaseManager.addData(model: 'petModel', data: localPetData);
    return true;
  }

  List getAllergies(){
    return constants.allergies;
  }

  List getDisabilities(){
    return constants.disabilities;
  }

  Future<bool> addRoutine(String routineName, DateTime time, int id, String idName, bool isActive) async {
    this.routines[routineName.toLowerCase()].add(RemainderFieldModel(time: time, isActive: isActive, id: id));

    try{
      isActive ? notificationPlugin.showDailyAtTimeNotification(id: id, title: '$routineName Time', body: '${this.name} needs ${routineName.toLowerCase()}.', payload: null, time: time) : null;
      addRoutineToCloud(routineName);
      addRoutineToLocal();
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future<void> addRoutineToCloud(String routineName) async {
    DocumentReference document = await _fireStore.collection('PetModel').doc(this.id);
    await document.update({
      'routines.${routineName.toLowerCase()}': this.routines[routineName.toLowerCase()].map((e) => e.toMap()).toList(),
    });
  }

  void addRoutineToLocal(){
    databaseManager.updatePetRoutine(this.id, this.routines);
  }

  Future<void> cancelRoutine(id, routineName) async {
    DocumentReference document = await _fireStore.collection('PetModel').doc(this.id);
    await document.update({
      'routines.$routineName': this.routines[routineName],
    });
    notificationPlugin.cancelNotification(id: id);
  }
}