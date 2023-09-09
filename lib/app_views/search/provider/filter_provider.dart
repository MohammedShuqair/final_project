import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/search/repo/search_repo.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:flutter/widgets.dart';

class FilterProvider extends ChangeNotifier {
  late StatusRepository _statusRepository;
  late CategoryRepository _categoryRepository;
  ApiResponse<StatusResponse>? statusResponse;
  ApiResponse<List<Category>>? categoriesResponse;

  List<String> categoryNames = [];
  int? statusId;
  String? startDate;
  String? endDate;

  void handelCategories(String name) {
    if (categoryNames.contains(name)) {
      _unSelectCategory(name);
    } else {
      _selectCategory(name);
    }
  }

  void handelStatus(int id) {
    if (statusId == id) {
      _unSetStatusId();
    } else {
      _setStatusId(id);
    }
  }

  void _selectCategory(String name) {
    categoryNames.add(name);
    notifyListeners();
  }

  void _unSelectCategory(String name) {
    categoryNames.remove(name);
    notifyListeners();
  }

  void _setStatusId(int id) {
    statusId = id;
    notifyListeners();
  }

  void _unSetStatusId() {
    statusId = null;
    notifyListeners();
  }

  void setStartDat(String date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDat(String date) {
    endDate = date;
    notifyListeners();
  }

  FilterProvider({
    this.categoryNames = const [],
    this.statusId,
    this.startDate,
    this.endDate,
  }) {
    _categoryRepository = CategoryRepository();
    _statusRepository = StatusRepository();

    getAllCategories();
    getAllStatus();
  }

  Future<void> getAllCategories() async {
    categoriesResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Category> categories =
          await _categoryRepository.getAllCategory();
      categoriesResponse = ApiResponse.completed(categories,
          message: 'Categories fetched successfully');
      print("here");
      print(categories);

      notifyListeners();
    } catch (e, s) {
      categoriesResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getAllStatus() async {
    statusResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final StatusResponse statuses =
          await _statusRepository.getAllStatus(false);
      statusResponse = ApiResponse.completed(statuses,
          message: 'Statuses fetched successfully');
      notifyListeners();
    } catch (e, s) {
      statusResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
