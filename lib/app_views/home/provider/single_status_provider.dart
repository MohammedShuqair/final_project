import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/constants.dart';
import 'package:final_project/core/util/extensions.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:flutter/cupertino.dart';

class SingleStatusProvider extends ChangeNotifier {
  late StatusRepository _repository;
  late ApiResponse<Map<String, List<Mail>>> singleStatus;
  late Status selectedStatus;
  SingleStatusProvider(Status status) {
    selectedStatus = status;
    _repository = StatusRepository();
    getSingleStatus();
  }
  Future<void> getSingleStatus() async {
    singleStatus = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Status status =
          await _repository.getSingleStatus(selectedStatus.id!, true);
      Map<String, List<Mail>> data = {};
      data.filterMailsByCategory(defaultCategories, status.mails ?? []);
      data.removeWhere((key, value) => value.isEmpty);
      //From Chat GPT
      // Convert the map into a list of key-value pairs
      List<MapEntry<String, List<Mail>>> entryList = data.entries.toList();
      // Sort the list in descending order based on the keys
      entryList.sort((a, b) => b.value.length.compareTo(a.value.length));

      // Create a new map from the sorted list
      Map<String, List<Mail>> sortedMap = Map.fromEntries(entryList);
      singleStatus = ApiResponse.completed(sortedMap,
          message: 'Status fetched successfully');
      notifyListeners();
    } catch (e, s) {
      singleStatus = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
