extension DateExtensions on DateTime{
  String getMonthName() {
    switch (this.month) {
      case 1:
        return 'Ocak';
      case 2:
        return 'Şubat';
      case 3:
        return 'Mart';
      case 4:
        return 'Nisan';
      case 5:
        return 'Mayıs';
      case 6:
        return 'Haziran';
      case 7:
        return 'Temmuz';
      case 8:
        return 'Ağustos';
      case 9:
        return 'Eylül';
      case 10:
        return 'Ekim';
      case 11:
        return 'Kasım';
      case 12:
        return 'Aralık';
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