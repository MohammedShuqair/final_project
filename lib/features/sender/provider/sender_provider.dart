import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/sender/models/sender_response.dart';
import 'package:final_project/features/sender/repo/sender_repo.dart';
import 'package:flutter/foundation.dart';

class SenderProvider extends ChangeNotifier {
  late SenderRepository _repository;
  ApiResponse<SenderResponse>? allSenderResponse;
  ApiResponse<Sender>? createSenderResponse;
  ApiResponse<Sender>? updateSenderResponse;
  ApiResponse<String>? deleteSenderResponse;
  SenderProvider() {
    _repository = SenderRepository();
  }
  Future<void> getAllSenders(
    int pageNum,
    bool withMail,
  ) async {
    allSenderResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final SenderResponse senderResponse =
          await _repository.getAllSender(pageNum, withMail);
      allSenderResponse = ApiResponse.completed(senderResponse,
          message: 'Senders fetched successfully');
      notifyListeners();
    } catch (e) {
      allSenderResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> createSender(
    String name,
    String mobile,
    String address,
    String categoryId,
  ) async {
    createSenderResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Sender? sender = await _repository.createSender(
          name: name, mobile: mobile, address: address, categoryId: categoryId);
      if (sender == null) {
        throw 'error in creating sender';
      }
      createSenderResponse =
          ApiResponse.completed(sender, message: 'Sender created successfully');
      notifyListeners();
    } catch (e) {
      createSenderResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> updateSender(
    int id,
    String name,
    String mobile,
    String? address,
    String categoryId,
  ) async {
    updateSenderResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Sender? sender = await _repository.updateSender(
          id: id,
          name: name,
          mobile: mobile,
          address: address,
          categoryId: categoryId);
      if (sender == null) {
        throw 'error in updating sender';
      }
      updateSenderResponse =
          ApiResponse.completed(sender, message: 'Sender created successfully');
      notifyListeners();
    } catch (e) {
      updateSenderResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteSenders(int senderId) async {
    deleteSenderResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final String message = await _repository.deleteSender(id: senderId);
      deleteSenderResponse = ApiResponse.completed(message, message: message);
      notifyListeners();
    } catch (e) {
      deleteSenderResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
