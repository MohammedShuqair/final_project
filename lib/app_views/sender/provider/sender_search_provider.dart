import 'dart:async';

import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/sender/models/sender_response.dart';
import 'package:final_project/features/sender/repo/sender_repo.dart';
import 'package:flutter/cupertino.dart';

class SenderSearchProvider extends ChangeNotifier {
  late SenderRepository _repository;
  ApiResponse<SenderResponse>? allSenderResponse;
  late ScrollController scrollController;
  String? senderName;
  StreamController<int> controller = StreamController<int>();
  int currentPage = 1;
  int firstPage = 1;
  int? lastPage;
  late bool withMails;
  List<Sender> store = [];

  SenderSearchProvider(this.withMails) {
    _repository = SenderRepository();
    getAllSenders();
    scrollController = ScrollController(
      onAttach: _handlePositionAttach,
      onDetach: _handlePositionDetach,
    );
  }
  void _handlePagination() {
    if ((scrollController.position.maxScrollExtent ==
            scrollController.position.pixels) &&
        currentPage <= (lastPage ?? firstPage) &&
        (allSenderResponse?.status != ApiStatus.LOADING ||
            allSenderResponse?.status != ApiStatus.MORE)) {
      currentPage++;
      getAllSenders();
      print('currentPage $currentPage');
    }
  }

  void _handlePositionAttach(ScrollPosition position) {
    position.isScrollingNotifier.addListener(_handlePagination);
  }

  void _handlePositionDetach(ScrollPosition position) {
    position.isScrollingNotifier.removeListener(_handlePagination);
  }

  void onSearchSubmitted(String name) {
    senderName = name;
    reset();
    search();

    notifyListeners();
  }

  void reset() {
    allSenderResponse?.data = null;
    store = [];
    currentPage = 1;
    notifyListeners();
  }

  Future<void> search() async {
    allSenderResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    SenderResponse? senderResponse;
    try {
      for (; currentPage <= (lastPage ?? firstPage); currentPage++) {
        senderResponse = await _repository.getAllSender(currentPage, withMails);
        lastPage = senderResponse.lastPage;

        if (senderName != null && senderResponse.senders != null) {
          senderResponse.senders?.removeWhere((sender) =>
              !sender.name!.toLowerCase().contains(senderName!.toLowerCase()));
        }
        if (senderResponse.senders != null) {
          store.addAll(senderResponse.senders!);
        }
      }
      senderResponse?.senders = store;
      allSenderResponse = ApiResponse.completed(senderResponse,
          message: 'Senders fetched successfully');
      notifyListeners();
    } catch (e) {
      allSenderResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getAllSenders() async {
    if (allSenderResponse?.data == null) {
      allSenderResponse = ApiResponse.loading(message: 'logging...');
    } else {
      allSenderResponse = ApiResponse.more(
          message: 'logging...', data: allSenderResponse?.data);
    }
    notifyListeners();
    try {
      final SenderResponse senderResponse =
          await _repository.getAllSender(currentPage, withMails);
      lastPage = senderResponse.lastPage;
      // if (senderName != null && senderResponse.senders != null) {
      //   senderResponse.senders?.removeWhere((sender) =>
      //       !sender.name!.toLowerCase().contains(senderName!.toLowerCase()));
      // }
      if (senderResponse.senders != null) {
        store.addAll(senderResponse.senders!);
        senderResponse.senders = store;
      }
      allSenderResponse = ApiResponse.completed(senderResponse,
          message: 'Senders fetched successfully');
      notifyListeners();
    } catch (e) {
      allSenderResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
