import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:repetapp/services/database.dart';

enum VaccineDataSegment {
  first_shot,
  period,
}

class VaccineModel {
  FirebaseFirestore _fireStore;

  VaccineModel() {
    _fireStore = FirebaseFirestore.instance;
  }

  bool isFormatted;
  String _id;
  String _name;
  Map<String, dynamic> _firstShot;
  Map<String, dynamic> _period;
  Map<String, DateTime> _periodsFetched;
  Map<String, DateTime> _firstShotsFetched;

  // In future, we might need to check the validness of the form of the data.
  // So, writing getters and setters for this purpose is a good idea.

  // Getters

  String get docId {
    return _id;
  }

  String get name {
    return _name;
  }

  Map<String, DateTime> get firstShot {
    return {..._firstShotsFetched};
  }

  Map<String, DateTime> get period {
    return {..._periodsFetched};
  }

  // Setters

  set docId(String newVal) {
    this._id = newVal;
  }

  set vaccineName(String newVal) {
    this._name = newVal;
  }
  //////////////////////////////////////////////////////////////////////////////

  bool fetchData(Map<String, dynamic> vaccineData) {
    try {
      this._name = vaccineData["name"];
      this._period = vaccineData["period"];
      this._firstShot = vaccineData["first_shot"];

      bool fetch1 = this._formatData(VaccineDataSegment.period);
      bool fetch2 = this._formatData(VaccineDataSegment.first_shot);

      return (true && fetch1 && fetch2);
    } catch (error) {
      return false;
    }
  }

  bool _formatData(VaccineDataSegment mode) {
    Map<String, String> dataMap;
    Map<String, DateTime> outMap;
    if (mode == VaccineDataSegment.period) {
      dataMap = this._period;
      outMap = this._periodsFetched;
    } else if (mode == VaccineDataSegment.first_shot) {
      dataMap = this._firstShot;
      outMap = this._firstShotsFetched;
    } else {
      return false;
    }

    if (dataMap.isNotEmpty) {
      dataMap.forEach((petType, value) {
        DateTime date = DateTime(0, 0, 0, 0, 0, 0);
        List<String> params = value.split(" ");
        String type = params[1];
        if (params[0].contains('-')) {
          List<String> bounds = params[0].split("-");
          int lowerBound = int.tryParse(bounds[0]);
          // int upperBound = int.tryParse(bounds[1]);
          switch (type) {
            case "day":
              {
                date = DateTime(0, 0, lowerBound, 0, 0, 0);
                break;
              }
            case "week":
              {
                date = DateTime(0, 0, lowerBound * 7, 0, 0, 0);
                break;
              }
            case "month":
              {
                date = DateTime(0, lowerBound, 0, 0, 0, 0);
                break;
              }
            case "year":
              {
                date = DateTime(lowerBound, 0, 0, 0, 0, 0);
                break;
              }
            default:
              {
                return false;
              }
          }
        } else {
          int amount = int.tryParse(params[0]);
          switch (type) {
            case "day":
              {
                date = DateTime(0, 0, amount, 0, 0, 0);
                break;
              }
            case "week":
              {
                date = DateTime(0, 0, amount * 7, 0, 0, 0);
                break;
              }
            case "month":
              {
                date = DateTime(0, amount, 0, 0, 0, 0);
                break;
              }
            case "year":
              {
                date = DateTime(amount, 0, 0, 0, 0, 0);
                break;
              }
            default:
              {
                return false;
              }
          }
        }
        outMap[petType] = date;
      });
      return true;
    } else {
      return false;
    }
  }
}
