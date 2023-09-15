import 'dart:io';

import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/core/util/shared_mrthodes.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewInboxProvider extends ChangeNotifier {
  late CategoryRepository categoryRepository;
  late TagRepository tagRepository;
  ApiResponse<List<Category>>? allCategoryResponse;
  ApiResponse<Set<Tag>>? allTagResponse;

  late Category selectedCategory;
  static NewInboxProvider get(context) => Provider.of(context);
  late TextEditingController senderName;
  late TextEditingController senderMobile;
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
    archiveDate = DateTime.now();
    formKey = GlobalKey<FormState>();
    categoryRepository = CategoryRepository();
    tagRepository = TagRepository();
    selectedCategory = Category(id: 1, name: 'Other');

    senderName = TextEditingController();
    senderMobile = TextEditingController();
    subject = TextEditingController();
    description = TextEditingController();
    decision = TextEditingController();
    archiveNumber = TextEditingController();
    // getAllCategories();
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
    selectedCategory = sender.category!;
  }

  void _removeSenderData() {
    senderName.text = '';
    senderMobile.text = '';
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
    print(activities);
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
    bool x = activities.remove(activity);
    print(x);
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
    print(category);
    notifyListeners();
  }

  Future<void> getAllTags() async {
    allTagResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final List<Tag> tags = await tagRepository.getAllTag();
      allTagResponse = ApiResponse.completed(tags.toSet(),
          message: 'Tags fetched successfully');
      notifyListeners();
    } catch (e, s) {
      allTagResponse = ApiResponse.error(message: e.toString());
      print(s);
      notifyListeners();
    }
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
      } catch (e, s) {
        allCategoryResponse = ApiResponse.error(message: e.toString());
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    senderName.dispose();
    senderMobile.dispose();
    subject.dispose();
    description.dispose();
    decision.dispose();
    archiveNumber.dispose();
    print('new Inbox desposed');
    super.dispose();
  }
}
