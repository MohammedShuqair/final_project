import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
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
      Map<String, List<Mail>> sortedMap =
          mailsToCategoriesMap(status.mails ?? []);
      singleStatus = ApiResponse.completed(sortedMap,
          message: 'Status fetched successfully');
      notifyListeners();
    } catch (e) {
      singleStatus = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
