import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/sender/models/sender_response.dart';

class SenderRepository with ApiBaseHelper {
  Future<SenderResponse> getAllSender(
    int pageNum,
    bool withMail,
  ) async {
    final response = await get('senders?mail=$withMail&page=$pageNum');
    return SenderResponse.fromMap(response['senders']);
  }

  Future<Sender> getSingleSender(
    int senderId,
    bool withMail,
  ) async {
    final response = await get('senders/$senderId?mail=$withMail');
    return Sender.fromMap(response);
  }

  Future<Sender?> createSender({
    required String name,
    required String mobile,
    required String address,
    required String categoryId,
  }) async {
    final response = await post(
      'senders',
      {
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId
      },
    );
    List<Sender> list = Sender.mapValueToList(response['sender']);
    if (list.isNotEmpty) {
      return list[0];
    } else {
      return null;
    }
  }

  Future<Sender?> updateSender({
    required int id,
    required String name,
    required String mobile,
    String? address,
    required String categoryId,
  }) async {
    final response = await put(
      'senders/$id',
      {
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId
      },
    );
    return Sender.fromMap(response['sender']);
  }

  Future<String> deleteSender({
    required int id,
  }) async {
    final response = await delete('senders/$id');
    return response['sender'];
  }
}
