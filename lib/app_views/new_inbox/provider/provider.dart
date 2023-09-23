import 'dart:io';

import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/features/mail/models/activity.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:final_project/features/mail/models/mail.dart';
import 'package:final_project/features/mail/repo/mail_repo.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/sender/repo/sender_repo.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewInboxProvider extends ChangeNotifier {
  late CategoryRepository categoryRepository;
  late TagRepository tagRepository;
  late MailRepository mailRepository;
  late SenderRepository senderRepository;
  ApiResponse<List<Category>>? allCategoryResponse;
  ApiResponse<Set<Tag>>? allTagResponse;
  ApiResponse<bool>? createMailResponse;

  late Category selectedCategory;
  static NewInboxProvider get(context) => Provider.of(context);
  late TextEditingController senderName;
  late TextEditingController senderMobile;
  late TextEditingController senderAddress;
  late TextEditingController subject;
  late TextEditingController description;
  late TextEditingController decision;
  late TextEditingController archiveNumber;
  late DateTime archiveDate;
  Status? selectedStatus;
  String? finalDecision;
  Set<Tag> selectedTags = {};
  List<Activity> activities = [];
  List<Activity> editingActivities = [];
  List<XFile> attachments = [];
  Sender? pickedSender;
  late GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  NewInboxProvider() {
    senderRepository = SenderRepository();
    mailRepository = MailRepository();
    archiveDate = DateTime.now();
    formKey = GlobalKey<FormState>();
    categoryRepository = CategoryRepository();
    tagRepository = TagRepository();
    selectedCategory = Category(id: 1, name: 'Other');

    senderName = TextEditingController();
    senderMobile = TextEditingController();
    senderAddress = TextEditingController();
    subject = TextEditingController();
    description = TextEditingController();
    decision = TextEditingController();
    archiveNumber = TextEditingController();
    // getAllCategories();
  }
  Future<void> createMail() async {
    if (formKey.currentState?.validate() ?? false) {
      createMailResponse = ApiResponse.loading(message: 'creating...');
      notifyListeners();
      try {
        String senderId = await getSenderId();
        List<int> tags = await getTagsIdList();
        Mail mail = await mailRepository.createMail(
          subject: subject.text,
          archiveNumber: archiveNumber.text,
          archiveDate: archiveDate.toString(),
          statusId: selectedStatus!.id.toString(),
          description: description.text,
          senderId: senderId,
          decision: decision.text,
          finalDecision: selectedStatus!.id == 4 ? decision.text : '',
          tags: tags,
          activities: activities.map((e) => e.toMap()).toList(),
        );
        await uploadAttachment(mail);
        createMailResponse = ApiResponse.completed(true,
            message: '${mail.subject} created sucssesfully');
      } catch (e) {
        createMailResponse = ApiResponse.error(message: '$e');
      }
    }
  }

  Future<List<Attachment>> uploadAttachment(Mail mail) async {
    List<Attachment> a = [];
    if (attachments.isNotEmpty) {
      attachments.forEach((attachment) async {
        a.add(await mailRepository.uploadAttachment(
            mail.id!, mail.subject ?? '', attachment.path));
      });
    }
    return a;
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

  Future<String> getSenderId() async {
    if (pickedSender != null && pickedSender?.id != null) {
      return pickedSender!.id!.toString();
    } else {
      Sender? sender = await senderRepository.createSender(
          name: senderName.text,
          mobile: senderMobile.text,
          address: senderAddress.text,
          categoryId: selectedCategory.id.toString());
      return sender!.id!.toString();
    }
  }

  void addAttachment(List<XFile> xFiles) {
    attachments.addAll(xFiles);
    notifyListeners();
  }

  void removeAttachment(String path) {
    for (int i = 0; i < attachments.length; i++) {
      if (attachments[i].path == path) {
        File(path).delete().then((value) {
          attachments.remove(attachments[i]);
          notifyListeners();
        });
        break;
      }
    }
  }

  void setArchiveDate(DateTime dateTime) {
    archiveDate = dateTime;
    notifyListeners();
  }

  void addSenderName(String name) {
    pickedSender = null;
    _removeSenderData();
    senderName.text = name;
    notifyListeners();
  }

  void _setSenderData(Sender sender) {
    senderName.text = sender.name ?? '';
    senderMobile.text = sender.mobile ?? '';
    senderAddress.text = sender.address ?? '';
    selectedCategory = sender.category!;
  }

  void _removeSenderData() {
    senderName.text = '';
    senderMobile.text = '';
    senderAddress.text = '';
    selectedCategory = Category(id: 1, name: 'Other');
  }

  void setSender(Sender sender) {
    pickedSender = sender;
    _setSenderData(sender);
    notifyListeners();
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

  void addEditingActivity(Activity activity) {
    editingActivities.add(activity);
    notifyListeners();
  }

  void editActivityBody(String body, Activity activity) {
    activity.body = body;
    editingActivities.remove(activity);
    notifyListeners();
  }

  void removeEditingActivity(Activity activity) {
    editingActivities.remove(activity);
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

  void setTags(Set<Tag> list) {
    selectedTags = list;
    notifyListeners();
  }

  void setCategory(Category category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> getAllCategories() async {
    if (allCategoryResponse == null ||
        allCategoryResponse?.data == null ||
        allCategoryResponse!.data!.isEmpty) {
      allCategoryResponse = ApiResponse.loading(message: 'logging...');
      notifyListeners();
      try {
        final List<Category> categories =
            await categoryRepository.getAllCategory();
        allCategoryResponse = ApiResponse.completed(categories,
            message: 'Categories fetched successfully');

        for (int i = 0; i < categories.length; i++) {
          if (categories[i].name?.toLowerCase().contains('other') ?? false) {
            selectedCategory = categories[i];
            break;
          }
        }

        notifyListeners();
      } catch (e) {
        allCategoryResponse = ApiResponse.error(message: e.toString());
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    senderName.dispose();
    senderMobile.dispose();
    senderAddress.dispose();
    subject.dispose();
    description.dispose();
    decision.dispose();
    archiveNumber.dispose();
    super.dispose();
  }
}
