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
  String? startDate;
  String? endDate;

  void handelCategories(Category category) {
    if (categories.contains(category)) {
      _unSelectCategory(category);
    } else {
      _selectCategory(category);
    }
  }

  void handelStatus(Status? selected) {
    if (status?.id == selected?.id || selected == null) {
      print(status?.id);
      print(selected?.id);

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
    categories.remove(category);
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

  void setStartDat(String date) {
    startDate = date;
    notifyListeners();
  }

  void setEndDat(String date) {
    endDate = date;
    notifyListeners();
  }

  FilterProvider({
    this.categories = const [],
    this.status,
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
