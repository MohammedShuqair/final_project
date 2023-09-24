import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/auth/model/user.dart';

class CurrentUserRepository with ApiBaseHelper {
  Future<User> getCurrentUser() async {
    final response = await get(
      'user',
    );
    print(response);
    return User.fromMap(response['user']);
  }

  Future<User> updateUser(String name, String? imagePath) async {
    final response = await postWithImage(
        'user/update',
        {
          'name': name,
        },
        filePath: imagePath);
    return User.fromMap(response['user']);
  }

  Future logout() async {
    final response = await post('logout', null);
    return response;
  }
}
