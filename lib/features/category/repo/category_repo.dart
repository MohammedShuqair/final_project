import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/category/models/category.dart';

class CategoryRepository with ApiBaseHelper {
  Future<List<Category>> getAllCategory() async {
    final response = await get(
      'categories',
    );
    return Category.mapValueToList(response['categories']);
  }

  Future<Category?> getSingleCategory(int id) async {
    final response = await get(
      'categories/$id',
    );
    print('category response $response');

    List<Category> list = Category.mapValueToList(response['category']);

    if (list.isNotEmpty) {
      return list[0];
    } else {
      return null;
    }
  }
}
