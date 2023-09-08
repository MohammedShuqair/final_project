import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/search/repo/search_repo.dart';
import 'package:flutter/widgets.dart';

class SearchProvider extends ChangeNotifier {
  late SearchRepository _searchRepository;
  ApiResponse<Map<String, List<Mail>>>? searchResponse;

  SearchProvider() {
    _searchRepository = SearchRepository();
  }
  void resetResponse() {
    searchResponse = null;
    notifyListeners();
  }

  Future<void> search({
    String? searchFor,
    String? startDate,
    String? endDate,
    int? statusId,
  }) async {
    searchResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Map<String, List<Mail>> searchMap = await _searchRepository.search(
          searchFor: searchFor,
          startDate: startDate,
          endDate: endDate,
          statusId: statusId);
      searchResponse = ApiResponse.completed(searchMap,
          message: 'search completed successfully');
      notifyListeners();
    } catch (e, s) {
      searchResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
