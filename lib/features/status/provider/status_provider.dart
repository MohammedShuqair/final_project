import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:flutter/foundation.dart';

class StatusProvider extends ChangeNotifier {
  late StatusRepository _repository;
  late ApiResponse<StatusResponse> allStatus;
  late ApiResponse<Status> singleStatus;
  StatusProvider() {
    _repository = StatusRepository();
  }
  Future<void> getAllStatus(bool withMails) async {
    allStatus = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final StatusResponse statuses = await _repository.getAllStatus(withMails);
      allStatus = ApiResponse.completed(statuses,
          message: 'Statuses fetched successfully');
      notifyListeners();
    } catch (e, s) {
      allStatus = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getSingleStatus(int id, bool withMails) async {
    singleStatus = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Status status = await _repository.getSingleStatus(id, withMails);
      singleStatus =
          ApiResponse.completed(status, message: 'Status fetched successfully');
      notifyListeners();
    } catch (e, s) {
      singleStatus = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
