import 'dart:convert';

import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/tag/models/tag.dart';

class TagRepository with ApiBaseHelper {
  Future<List<Tag>> getAllTag() async {
    final response = await get(
      'tags',
    );
    return Tag.mapValueToList(response['tags']);
  }

  Future<List<Tag>> getTagsWithMails(List<int> tagsIds) async {
    final response = await get(
      'tags?tags=${jsonEncode(tagsIds)}',
    );
    return Tag.mapValueToList(response['tags']);
  }

  Future<List<Tag>> getMailTags(int mailId) async {
    final response = await get(
      'mails/$mailId/tags',
    );
    return Tag.mapValueToList(response['tags']);
  }
}
