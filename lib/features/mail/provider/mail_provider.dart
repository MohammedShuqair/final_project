import 'package:final_project/core/util/api_response.dart';
import 'package:flutter/foundation.dart';

class MailProvider extends ChangeNotifier {
  List<String> test = [];
  void setData(List<String> data) {
    test = data;
    notifyListeners();
  }
}
