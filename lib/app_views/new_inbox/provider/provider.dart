import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/activity/models/activity.dart';
import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/category/repo/category_repo.dart';
import 'package:final_project/features/tag/models/tag.dart';
import 'package:final_project/features/tag/repo/tag_repo.dart';
import 'package:flutter/widgets.dart';
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
  late TextEditingController senderCategory;
  late TextEditingController subject;
  late TextEditingController description;
  late TextEditingController decision;
  late TextEditingController archiveNumber;
  String? archiveDate;
  String? statusId;
  String? senderId;
  // String? decision;
  String? finalDecision;
  Set<Tag> selectedTags = {};
  List<Activity> activities = [];

  NewInboxProvider() {
    categoryRepository = CategoryRepository();
    tagRepository = TagRepository();
    selectedCategory = Category(id: 1, name: 'Other');

    senderName = TextEditingController();
    senderMobile = TextEditingController();
    senderCategory = TextEditingController();
    subject = TextEditingController();
    description = TextEditingController();
    decision = TextEditingController();
    archiveNumber = TextEditingController();
    // getAllCategories();
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
    senderCategory.dispose();
    subject.dispose();
    description.dispose();
    decision.dispose();
    archiveNumber.dispose();
    print('new Inbox desposed');
    super.dispose();
  }
}
