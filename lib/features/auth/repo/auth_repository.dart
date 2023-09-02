import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/auth/model/user_response.dart';

class AuthRepository with ApiBaseHelper {
  Future<UserResponse> login(String email, String password) async {
    final response = await post(
      'login',
      {"email": email, "password": password},
    );
    return UserResponse.fromMap(response);
  }

  Future<UserResponse> register(
    String email,
    String name,
    String password,
    String passwordConfirmation,
  ) async {
    final response = await post('register', {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation
    });
    return UserResponse.fromMap(response);
  }
}
