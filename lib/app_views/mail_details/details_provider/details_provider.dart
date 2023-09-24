import 'dart:io';

import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/shared_methodes.dart';
import 'package:final_project/features/mail/models/activity.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/mail/repo/mail_repo.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/material.dart';

class DetailsProvider extends ChangeNotifier {
  late Mail mail;
  late MailRepository mailRepository;
  late TagRepository tagRepository;
  ApiResponse<String>? deleteResponse;
  ApiResponse<Mail>? updateResponse;

  Status? selectedStatus;
  Set<Tag> selectedTags = {};
  late TextEditingController decision;
  List<Attachment> attachments = [];
  List<Attachment> removedAttachments = [];
  List<Activity> activities = [];
  List<Activity> editingActivities = [];
  late GlobalKey<FormState> formKey;

  DetailsProvider(this.mail) {
    formKey = GlobalKey<FormState>();
    tagRepository = TagRepository();
    mailRepository = MailRepository();
    selectedTags.addAll(mail.tags?.toSet() ?? {});
    selectedStatus = mail.status;
    decision = TextEditingController(text: mail.decision ?? '');
    attachments.addAll(mail.attachments ?? []);
    activities.addAll(mail.activities?.toList() ?? []);
  }

  Future<void> deleteMail() async {
    deleteResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final String message = await mailRepository.deleteMail(mail.id!);
      deleteResponse = ApiResponse.completed(message, message: message);
      notifyListeners();
    } catch (e) {
      deleteResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> updateEmail() async {
    if (formKey.currentState?.validate() ?? false) {
      updateResponse = ApiResponse.loading(message: 'updating...');
      notifyListeners();
      try {
        List<int> tags = await getTagsIdList();
        Mail updatedMail = await mailRepository.updateMail(
          mailId: mail.id,
          statusId: selectedStatus!.id.toString(),
          decision: decision.text,
          finalDecision: selectedStatus!.id == 4 ? decision.text : '',
          tags: tags,
          idAttachmentsForDelete: removedAttachments.map((e) => e.id!).toList(),
          pathAttachmentsForDelete:
              removedAttachments.map((e) => e.image ?? '').toList(),
          activities: getNewActivities(),
        );
        await uploadAttachment(updatedMail);
        updateResponse = ApiResponse.completed(updatedMail,
            message: '${updatedMail.subject} Mail updated successfully');
        notifyListeners();
      } catch (e) {
        updateResponse = ApiResponse.error(message: e.toString());
        notifyListeners();
      }
    }
  }

  List<Map<String, dynamic>> getNewActivities() {
    List<Map<String, dynamic>> newActivities = [];
    activities.forEach((activity) {
      if (activity.id == null) {
        newActivities.add(activity.toMap());
      }
    });
    return newActivities;
  }

  void addActivity(
    String body,
  ) {
    User user = getUser();
    activities.add(Activity(
        body: body,
        user: user,
        userId: user.id.toString(),
        createdAt: DateTime.now().toString()));
    notifyListeners();
  }

  void removeEditingActivity(Activity activity) {
    editingActivities.remove(activity);
    notifyListeners();
  }

  void editActivityBody(String body, Activity activity) {
    activity.body = body;
    editingActivities.remove(activity);
    notifyListeners();
  }

  void addEditingActivity(Activity activity) {
    editingActivities.add(activity);
    notifyListeners();
  }

  void removeActivity(Activity activity) {
    activities.remove(activity);
    notifyListeners();
  }

  void setStatus(Status? status) {
    selectedStatus = status;
    notifyListeners();
  }

  void addAttachment(List<Attachment> images) {
    attachments.addAll(images);
    notifyListeners();
  }

  Future<List<Attachment>> uploadAttachment(Mail mail) async {
    List<Attachment> a = [];
    for (int i = 0; i < attachments.length; i++) {
      if (attachments[i].id == null && attachments[i].image != null) {
        Attachment attachment = await mailRepository.uploadAttachment(
            mail.id!, mail.subject ?? '', attachments[i].image);
        a.add(attachment);
      }
    }

    return a;
  }

  void removeAttachment(String path) {
    for (int i = 0; i < attachments.length; i++) {
      if (attachments[i].image == path) {
        if (attachments[i].id == null) {
          File(path).delete();
        } else {
          removedAttachments.add(attachments[i]);
        }
        attachments.remove(attachments[i]);
        notifyListeners();
        break;
      }
    }
  }

  Future<List<int>> getTagsIdList() async {
    List<int> ides = [];
    for (int i = 0; i < selectedTags.length; i++) {
      if (selectedTags.elementAt(i).id == null) {
        Tag tag =
            await tagRepository.createTag(selectedTags.elementAt(i).name!);
        ides.add(tag.id!);
      } else {
        ides.add(selectedTags.elementAt(i).id!);
      }
    }
    return ides;
  }

  void setTags(Set<Tag> list) {
    selectedTags = list;
    notifyListeners();
  }

  @override
  void dispose() {
    decision.dispose();
    super.dispose();
  }
}
