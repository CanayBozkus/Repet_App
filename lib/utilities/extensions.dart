import 'package:flutter_gen/gen_l10n/app_localizations.dart';


extension DateExtensions on DateTime{
  String getMonthName(AppLocalizations localized) {
    switch (this.month) {
      case 1:
        return localized.january;
      case 2:
        return localized.february;
      case 3:
        return localized.march;
      case 4:
        return localized.april;
      case 5:
        return localized.may;
      case 6:
        return localized.june;
      case 7:
        return localized.july;
      case 8:
        return localized.august;
      case 9:
        return localized.september;
      case 10:
        return localized.october;
      case 11:
        return localized.november;
      case 12:
        return localized.december;
      default:
        return 'Invalid';
    }
  }

  String getHourAndMinuteString(){
    String time = '';
    if(this.hour < 10){
      time += '0${this.hour}';
    }
    else{
      time += '${this.hour}';
    }
    time += ':';
    if(this.minute < 10){
      time += '0${this.minute}';
    }
    else{
      time += '${this.minute}';
    }
    return time;
  }
}

extension ListExtension on List{
  bool shallowListComparision(List list){
    if(this == null){
      return list == null;
    }
    else if(this.length != list.length){
      return false;
    }
    for(var element in this){
      if(!list.contains(element)){
        return false;
      }
    }
    return true;
  }
}