import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/status/models/status_response.dart';

class StatusRepository with ApiBaseHelper {
  Future<StatusResponse> getAllStatus(bool withMails) async {
    final response = await get(
      'statuses?mail=$withMails',
    );
    return StatusResponse.fromMap(response);
  }

  Future<Status> getSingleStatus(int id, bool withMails) async {
    final response = await get(
      'statuses/$id?mail=$withMails',
    );
    return Status.fromMap(response['status']);
  }
}
