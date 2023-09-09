import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class CategoryProvider extends ChangeNotifier {
  late CategoryRepository _repository;
  late ApiResponse<List<Category>> allCategory;
  ApiResponse<Category>? singleCategory;
  ApiResponse<Category>? createdCategoryResponse;

  CategoryProvider() {
    _repository = CategoryRepository();
    getAllCategories();
    getSingleCategory(1);
  }
  Future<void> getAllCategories() async {
    allCategory = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Category> categories = await _repository.getAllCategory();
      allCategory = ApiResponse.completed(categories,
          message: 'Categories fetched successfully');
      notifyListeners();
    } catch (e, s) {
      allCategory = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getSingleCategory(int id) async {
    singleCategory = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Category? category = await _repository.getSingleCategory(id);
      if (category == null) {
        throw 'error in fetching category';
      }
      singleCategory = ApiResponse.completed(category,
          message: 'Category fetched successfully');
      notifyListeners();
    } catch (e, s) {
      singleCategory = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> createCategory(String name) async {
    createdCategoryResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Category category = await _repository.createCategory(name);
      createdCategoryResponse = ApiResponse.completed(category,
          message: 'Category created successfully');
      notifyListeners();
    } catch (e, s) {
      createdCategoryResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
