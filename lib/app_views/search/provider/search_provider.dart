import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/search/repo/search_repo.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:flutter/widgets.dart';

class SearchProvider extends ChangeNotifier {
  late SearchRepository _searchRepository;
  late StatusRepository _statusRepository;
  late CategoryRepository _categoryRepository;
  ApiResponse<Map<String, List<Mail>>>? searchResponse;
  ApiResponse<StatusResponse>? statusResponse;
  ApiResponse<List<Category>>? categoriesResponse;
  String? searchFor;

  List<Category> categories = [];
  Status? status;
  String? startDate;
  String? endDate;
  void setCategories(List<Category> categoriesFilter) {
    categories = categoriesFilter;
    notifyListeners();
  }

  void setStatusId(Status? selected) {
    status = selected;
    notifyListeners();
  }

  void setStartDat(String? date) {
    startDate = date;
    notifyListeners();
  }

  void setSearchFor(String? text) {
    searchFor = text;
    notifyListeners();
  }

  void setEndDat(String? date) {
    endDate = date;
    notifyListeners();
  }

  SearchProvider() {
    _searchRepository = SearchRepository();
    _categoryRepository = CategoryRepository();
    _statusRepository = StatusRepository();
  }
  void resetResponse() {
    searchResponse = null;
    searchFor = null;
    notifyListeners();
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

  Future<void> search(
      /*{
     String? searchFor,
     String? startDate,
     String? endDate,
     int? statusId,
  }*/
      ) async {
    searchResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Map<String, List<Mail>> searchMap = await _searchRepository.search(
          searchFor: searchFor,
          startDate: startDate,
          endDate: endDate,
          statusId: status?.id,
          categoriesFilter: categories.map((e) => e.name!).toList());
      searchResponse = ApiResponse.completed(searchMap,
          message: 'search completed successfully');
      notifyListeners();
    } catch (e, s) {
      searchResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
