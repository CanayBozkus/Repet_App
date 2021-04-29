import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/models/hive_models/hive_vaccine_model.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/models/vaccine_model.dart';

class VaccinesCollectionModel {
  FirebaseFirestore _fireStore;

  VaccinesCollectionModel() {
    _fireStore = FirebaseFirestore.instance;
  }

  bool _isDataFetched = false;
  List<VaccineModel> _vaccines;

  List<VaccineModel> get vaccines {
    return [..._vaccines];
  }

  Future<bool> createVaccinesCollection() async {
    try {
      if (!this._isDataFetched) {
        List<VaccineModel> newVaccines = [];
        final vaccines = await _fireStore.collection("VaccineModel").get();
        final vaccinesData = vaccines.docs;
        vaccinesData.forEach((vaccine) {
          Map<String, dynamic> data = vaccine.data();

          VaccineModel newModel = VaccineModel();
          bool isFetchSuccessfull = newModel.fetchData(data);
          // print(isFetchSuccessfull);
          if (isFetchSuccessfull) {
            // Store it in local database.
            final databaseModel = HiveVaccineModel(
              id: vaccine.id,
              name: newModel.name,
              firstShots: newModel.firstShot,
              periods: newModel.period,
            );
            databaseManager.addData(model: "vaccinemodel", data: databaseModel);

            // Store it in RAM.
            newVaccines.add(newModel);
          } else {
            return false;
          }
        });
        this._vaccines = newVaccines;
        this._isDataFetched = true;
      }
      return true;
    } catch (error) {
      // print(error);
      return false;
    }
  }

  Future<bool> updateVaccinesCollection() async {
    this._isDataFetched = false;
    return this.createVaccinesCollection();
  }
}
