import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/mail/repo/mail_repo.dart';
import 'package:final_project/features/status/models/status_response.dart';
import 'package:final_project/features/status/repo/status_repo.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/widgets.dart';
import 'package:final_project/core/util/extensions.dart';

class HomeProvider extends ChangeNotifier {
  late StatusRepository _statusRepository;
  late CategoryRepository _categoryRepository;
  late TagRepository _tagRepository;
  late MailRepository _mailRepository;

  late ApiResponse<StatusResponse> allStatus;
  late ApiResponse<Set<Tag>> allTagResponse;
  late ApiResponse<Map<String, List<Mail>>> allMailsResponse;
  Set<Tag> selectedTag = {};
  HomeProvider() {
    _statusRepository = StatusRepository();
    _mailRepository = MailRepository();
    _categoryRepository = CategoryRepository();
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
    allMailsResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Category> categories =
          await _categoryRepository.getAllCategory();
      final List<Mail> mails = await _mailRepository.getMails();

      Map<String, List<Mail>> data = {};
      data.filterMailsByCategory(categories, mails);
      data.removeWhere((key, value) => value.isEmpty);
      //From Chat GPT
      // Convert the map into a list of key-value pairs
      List<MapEntry<String, List<Mail>>> entryList = data.entries.toList();
      // Sort the list in descending order based on the keys
      entryList.sort((a, b) => b.value.length.compareTo(a.value.length));

      // Create a new map from the sorted list
      Map<String, List<Mail>> sortedMap = Map.fromEntries(entryList);

      allMailsResponse = ApiResponse.completed(sortedMap,
          message: 'Mails per Category fetched successfully');
      notifyListeners();
    } catch (e, s) {
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
    allTagResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Tag> tags = await _tagRepository.getAllTag();
      allTagResponse = ApiResponse.completed(tags.toSet(),
          message: 'Tags fetched successfully');
      notifyListeners();
    } catch (e, s) {
      allTagResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getAllStatus(bool withMails) async {
    allStatus = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final StatusResponse statuses =
          await _statusRepository.getAllStatus(withMails);
      allStatus = ApiResponse.completed(statuses,
          message: 'Statuses fetched successfully');
      notifyListeners();
    } catch (e, s) {
      allStatus = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
