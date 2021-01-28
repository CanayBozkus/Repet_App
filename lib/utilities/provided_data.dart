import 'package:flutter/foundation.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/models/user_model.dart';

class ProvidedData with ChangeNotifier {
  double width;
  double height;

  UserModel currentUser = UserModel();
  Map<String, PetModel> pets;

  void updateWidthHeight(width, height){
    this.width = width;
    this.height = height;
    notifyListeners();
  }

  Future<void> getUserData() async {
    await currentUser.getUserData();
    notifyListeners();
  }

  Future<void> getPets() async {
    pets = await currentUser.getPets();
    notifyListeners();
  }
}