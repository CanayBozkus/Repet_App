import 'package:flutter/foundation.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/models/user_model.dart';

class ProvidedData with ChangeNotifier {
  double width;
  double height;

  UserModel currentUser = UserModel();
  Map<String, PetModel> pets;
  String currentShownPetIndex;
  bool isDataFetched = false;
  void updateWidthHeight(width, height){
    this.width = width;
    this.height = height;
    notifyListeners();
  }

  Future<void> getData() async {
    await this.getUserData();
    await this.getPets();
    this.isDataFetched = true;
    notifyListeners();
  }

  Future<void> getUserData() async {
    await currentUser.getUserData();
    notifyListeners();
  }

  Future<void> getPets() async {
    pets = await currentUser.getPets();
    currentShownPetIndex = currentUser.pets[0];
    notifyListeners();
  }

  Future<void> addNewRemainder(PetModel pet, String routineName, DateTime time) async {
    await currentUser.addRemainder(pet, routineName, time);
    notifyListeners();
  }

  Future<void> reActivateNewRemainder(PetModel pet, String routineName, DateTime time, id) async {
    await currentUser.reActivateRemainder(pet, routineName, time, id);
    notifyListeners();
  }

  Future<void> cancelRemainder(PetModel pet, id, name) async {
    await currentUser.cancelRemainder(pet, id, name);
    notifyListeners();
  }
}