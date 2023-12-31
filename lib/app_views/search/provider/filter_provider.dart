import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:flutter/widgets.dart';

class FilterProvider extends ChangeNotifier {
  late StatusRepository _statusRepository;
  late CategoryRepository _categoryRepository;
  ApiResponse<StatusResponse>? statusResponse;
  ApiResponse<List<Category>>? categoriesResponse;

  List<Category> categories = [];
  Status? status;
  DateTime startDate = DateTime(2023);
  DateTime endDate = DateTime.now();

  void handelCategories(Category category) {
    if (categories
        .map((e) => e.name?.toLowerCase())
        .contains(category.name?.toLowerCase())) {
      _unSelectCategory(category);
    } else {
      _selectCategory(category);
    }
  }

  void handelStatus(Status? selected) {
    if (status?.id == selected?.id || selected == null) {
      _unSetStatusId();
    } else {
      _setStatusId(selected);
    }
  }

  void _selectCategory(Category category) {
    categories.add(category);
    notifyListeners();
  }

  void _unSelectCategory(Category category) {
    categories.removeWhere((element) =>
        element.name?.toLowerCase() == category.name?.toLowerCase());
    notifyListeners();
  }

  void _setStatusId(Status selected) {
    status = selected;
    notifyListeners();
  }

  void _unSetStatusId() {
    status = null;
    notifyListeners();
  }

  void setStartDat(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDat(DateTime date) {
    endDate = date;
    notifyListeners();
  }

  FilterProvider({
    this.categories = const [],
    this.status,
    required this.startDate,
    required this.endDate,
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
      notifyListeners();
    } catch (e) {
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
    } catch (e) {
      statusResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
