import 'package:course_store/models/product.dart';
import 'package:flutter/cupertino.dart';

import '../models/course.dart';

class ProductProvider extends ChangeNotifier{
  late Product _product;

  Product get product => _product;

  void changeProduct({required Product product}){
    _product = product;
    notifyListeners();
  }
}