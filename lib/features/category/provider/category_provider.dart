import 'package:final_project/core/util/api_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class CategoryProvider extends ChangeNotifier {
  late ApiResponse<List<String>> response;
  CategoryProvider() {
    getAllCategories();
  }
  Future<void> getAllCategories() async {
    response = ApiResponse.loading();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    response = ApiResponse.completed(
        List.generate(30, (index) => lorem(paragraphs: 1, words: 10)));
    notifyListeners();
  }
}
