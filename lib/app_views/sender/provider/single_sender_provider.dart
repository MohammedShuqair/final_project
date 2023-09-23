import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/sender/repo/sender_repo.dart';
import 'package:flutter/material.dart';

class SingleSenderProvider extends ChangeNotifier {
  late SenderRepository _repository;
  late ApiResponse<Map<String, List<Mail>>> singleSender;
  late Sender selectedSender;
  SingleSenderProvider(Sender sender) {
    selectedSender = sender;
    singleSender = ApiResponse.completed(
        mailsToCategoriesMap(sender.mails ?? []),
        message: 'Sender fetched successfully');
    _repository = SenderRepository();
  }
  Future<void> getSingleSender() async {
    singleSender = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final Sender sender =
          await _repository.getSingleSender(selectedSender.id!, true);
      selectedSender = sender;
      Map<String, List<Mail>> sortedMap =
          mailsToCategoriesMap(sender.mails ?? []);
      singleSender = ApiResponse.completed(sortedMap,
          message: 'Sender fetched successfully');
      notifyListeners();
    } catch (e) {
      singleSender = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
