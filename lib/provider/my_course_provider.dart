

import 'package:flutter/cupertino.dart';

import '../models/course.dart';

class MyCourseProvider extends ChangeNotifier{
  late bool _isBuy = false;
  late Course _course;

  bool get isBuy => _isBuy;

  void changeIsBuy({required bool isBuy}){
    _isBuy = isBuy;
    notifyListeners();
  }

  Course get course => _course;

  void changeCourse({required Course course}){
    _course = course;
    notifyListeners();
  }
}