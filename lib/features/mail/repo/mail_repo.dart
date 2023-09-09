import 'dart:convert';

import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:final_project/features/mail/models/mail.dart';

class MailRepository with ApiBaseHelper {
  Future<Mail> createMail({
    required String subject,
    required String archiveNumber,
    required String archiveDate,
    required String statusId,
    String? description,
    String? senderId,
    String? decision,
    String? finalDecision,
    List<int>? tags,
    List<Activity>? activities,
  }) async {
    final response = await post('mails', {
      "subject": subject,
      "description": description,
      "sender_id": senderId,
      "archive_number": archiveNumber,
      "archive_date": archiveDate,
      "decision": decision,
      "status_id": statusId,
      "final_decision": finalDecision,
      "tags": jsonEncode(tags),
      "activities": jsonEncode(activities),
    });
    return Mail.fromMap(response['mail']);
  }

  Future<Mail> updateMail({
    required mailId,
    String? statusId,
    String? decision,
    String? finalDecision,
    List<int>? tags,
    List<int>? idAttachmentsForDelete,
    List<String>? pathAttachmentsForDelete,
    List<Activity>? activities,
  }) async {
    final response = await put('mails/$mailId', {
      "decision": decision,
      "status_id": statusId,
      "final_decision": finalDecision,
      "tags": jsonEncode(tags),
      "idAttachmentsForDelete": jsonEncode(idAttachmentsForDelete),
      "pathAttachmentsForDelete": jsonEncode(pathAttachmentsForDelete),
      "activities": jsonEncode(activities),
    });
    return Mail.fromMap(response['mail']);
  }

  Future<List<Mail>> getMails() async {
    final response = await get('mails');
    return Mail.mapValueToList(response['mails']);
  }

  Future<Attachment> uploadAttachment(
    int id,
    String title,
    String? imagePath,
  ) async {
    final response = await postWithImage(
        'attachments',
        {
          'title': title,
          'mail_id': id,
        },
        filePath: imagePath);
    return Attachment.fromMap(response['attachment']);
  }
}
