class RemainderFieldModel {
  DateTime time;
  bool isActive;
  int id;

  RemainderFieldModel({
    this.time,
    this.isActive,
    this.id,
  });

  Map toMap(){
    return {
      'time': this.time,
      'isActive': this.isActive,
      'id': this.id,
    };
  }

  static RemainderFieldModel fromMap(Map data){
    return RemainderFieldModel(
      time: data['time'],
      isActive: data['isActive'],
      id: data['id'],
    );
  }
}