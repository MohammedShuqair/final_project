import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/foundation.dart';

class TagProvider extends ChangeNotifier {
  late TagRepository _repository;
  late ApiResponse<List<Tag>> allTagResponse;
  ApiResponse<List<Tag>>? tagsWithMailsResponse;
  ApiResponse<List<Tag>>? getMailTagsResponse;

  TagProvider() {
    _repository = TagRepository();
    getAllTags();
  }
  Future<void> getAllTags() async {
    allTagResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Tag> tags = await _repository.getAllTag();
      allTagResponse =
          ApiResponse.completed(tags, message: 'Tags fetched successfully');
      notifyListeners();
    } catch (e) {
      allTagResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getTagsWithMails(List<int> tagsIds) async {
    tagsWithMailsResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Tag> tags = await _repository.getTagsWithMails(tagsIds);
      tagsWithMailsResponse = ApiResponse.completed(tags,
          message: 'Tags with mails fetched successfully');
      notifyListeners();
    } catch (e) {
      tagsWithMailsResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getMailTags(int mailId) async {
    getMailTagsResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Tag> tags = await _repository.getMailTags(mailId);
      getMailTagsResponse = ApiResponse.completed(tags,
          message: 'Mail tags fetched successfully');
      notifyListeners();
    } catch (e) {
      getMailTagsResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
