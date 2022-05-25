

import 'package:flutter/cupertino.dart';

class MainPositionProvider extends ChangeNotifier{
  late int _position = 0;


  int get position => _position;

  void changePosition({required int position}){
    _position = position;
    notifyListeners();
  }

}