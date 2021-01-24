import 'package:flutter/foundation.dart';

class ProvidedData with ChangeNotifier {
  double width;
  double height;

  void updateWidthHeight(width, height){
    this.width = width;
    this.height = height;
    notifyListeners();
  }
}