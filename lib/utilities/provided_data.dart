import 'package:flutter/foundation.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/models/user_model.dart';

class ProvidedData with ChangeNotifier {
  double width;
  double height;

  UserModel currentUser = UserModel();
  Map<String, PetModel> pets;
  String currentShownPetIndex;
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
    print('-------222----');
    pets = await currentUser.getPets();
    print('-------223----');
    print(pets);
    currentShownPetIndex = currentUser.pets[0];
    print('-------');
    print(pets);
    print(currentUser.pets);
    print('-------');
    notifyListeners();
  }
}