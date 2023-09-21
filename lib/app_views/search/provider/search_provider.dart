import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/search/repo/search_repo.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:flutter/widgets.dart';

class SearchProvider extends ChangeNotifier {
  late SearchRepository _searchRepository;
  ApiResponse<Map<String, List<Mail>>>? searchResponse;
  ApiResponse<StatusResponse>? statusResponse;
  ApiResponse<List<Category>>? categoriesResponse;
  String? searchFor;

  List<Category> categories = [];
  Status? status;
  DateTime startDate = DateTime(2023);
  DateTime endDate = DateTime.now();
  void setCategories(List<Category> categoriesFilter) {
    categories = categoriesFilter;
    notifyListeners();
  }

  void setStatusId(Status? selected) {
    status = selected;
    notifyListeners();
  }

  void setStartDat(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setSearchFor(String? text) {
    searchFor = text;
    notifyListeners();
  }

  void setEndDat(DateTime date) {
    endDate = date;
    notifyListeners();
  }

  SearchProvider() {
    _searchRepository = SearchRepository();
  }
  void resetResponse() {
    searchResponse = null;
    searchFor = null;
    notifyListeners();
  }

  Future<void> search() async {
    print('here');
    searchResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Map<String, List<Mail>> searchMap = await _searchRepository.search(
          searchFor: searchFor,
          startDate: startDate == null
              ? DateTime(2023).toString()
              : startDate.toString(),
          endDate:
              endDate == null ? DateTime.now().toString() : endDate.toString(),
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
