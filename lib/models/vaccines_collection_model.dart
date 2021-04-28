import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/models/vaccine_model.dart';

class VaccinesCollectionModel {
  FirebaseFirestore _fireStore;

  VaccinesCollectionModel() {
    _fireStore = FirebaseFirestore.instance;
  }

  bool _isDataFetched = false;
  List<VaccineModel> _vaccines;

  Future<bool> _fetchFromCloud() async {
    try {
      final vaccines = await _fireStore.collection("VaccineModel").get();
      final vaccinesData = vaccines.docs;

      vaccinesData.forEach((vaccine) {
        final data = vaccine.data();

        VaccineModel newModel = VaccineModel();
        bool isFetchSuccessfull = newModel.fetchData(data);

        if (isFetchSuccessfull) {
          // Store it in RAM.
          this._vaccines.add(newModel);

          // Store it in local database.
        } else {
          return false;
        }
      });

      this._isDataFetched = true;
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
