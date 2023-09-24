import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/mail/repo/mail_repo.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/widgets.dart';

class HomeProvider extends ChangeNotifier {
  late StatusRepository _statusRepository;
  // late CategoryRepository _categoryRepository;
  late TagRepository _tagRepository;
  late MailRepository _mailRepository;

  ApiResponse<StatusResponse>? allStatus;
  ApiResponse<Set<Tag>>? allTagResponse;
  ApiResponse<Map<String, List<Mail>>>? allMailsResponse;
  Set<Tag> selectedTag = {};
  HomeProvider() {
    _statusRepository = StatusRepository();
    _mailRepository = MailRepository();
    // _categoryRepository = CategoryRepository();
    _tagRepository = TagRepository();

    init();
  }

  void addTag(Tag tag) {
    selectedTag.add(tag);
    notifyListeners();
  }

  void init() {
    getAllStatus(false);
    getAllMailsByCategories();
    getAllTags();
  }

  Future<void> getAllMailsByCategories() async {
    if (allMailsResponse?.data == null) {
      allMailsResponse = ApiResponse.loading(message: 'logging...');
    } else {
      allMailsResponse =
          ApiResponse.more(message: 'logging...', data: allMailsResponse?.data);
    }
    notifyListeners();

    try {
      // final List<Category> categories =
      //     await _categoryRepository.getAllCategory();
      final List<Mail> mails = await _mailRepository.getMails();

      Map<String, List<Mail>> sortedMap = mailsToCategoriesMap(mails);

      allMailsResponse = ApiResponse.completed(sortedMap,
          message: 'Mails per Category fetched successfully');
      notifyListeners();
    } catch (e) {
      allMailsResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  // Map<String, List<Mail>> filterCategoryMails(
  //     List<Category> categories, List<Mail> mails) {
  //   Map<String, List<Mail>> data = {};
  //   categories.forEach((category) {
  //     data.addAll({'${category.name}': []});
  //     mails.forEach((mail) {
  //       if (mail.sender?.categoryId == category.id.toString()) {
  //         data['${category.name}']?.add(mail);
  //         print('${category.name}');
  //       }
  //     });
  //   });
  //   return data;
  // }

  Future<void> getAllTags() async {
    if (allTagResponse?.data == null) {
      allTagResponse = ApiResponse.loading(message: 'logging...');
    } else {
      allTagResponse =
          ApiResponse.more(message: 'logging...', data: allTagResponse?.data);
    }
    notifyListeners();

    try {
      final List<Tag> tags = await _tagRepository.getAllTag();
      allTagResponse = ApiResponse.completed(tags.toSet(),
          message: 'Tags fetched successfully');
      notifyListeners();
    } catch (e) {
      allTagResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getAllStatus(bool withMails) async {
    if (allStatus?.data == null) {
      allStatus = ApiResponse.loading(message: 'logging...');
    } else {
      allStatus =
          ApiResponse.more(message: 'logging...', data: allStatus?.data);
    }
    notifyListeners();
    try {
      final StatusResponse statuses =
          await _statusRepository.getAllStatus(withMails);
      allStatus = ApiResponse.completed(statuses,
          message: 'Statuses fetched successfully');
      notifyListeners();
    } catch (e) {
      allStatus = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
