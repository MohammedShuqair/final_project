import 'package:final_project/features/category/models/category.dart';
import 'package:flutter/widgets.dart';

class MailProvider extends ChangeNotifier {
  List<Category> test = [];
  void setData(List<Category> data) {
    test = data;
    notifyListeners();
  }
}
