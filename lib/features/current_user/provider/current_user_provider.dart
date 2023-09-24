import 'dart:convert';

import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/current_user/repo/current_user_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  late CurrentUserRepository _repository;
  late ApiResponse<User> currentUserResponse;
  UserProvider() {
    _repository = CurrentUserRepository();
    String? userString = SharedHelper().getData(key: 'user');
    if (userString != null && userString.isNotEmpty) {
      currentUserResponse =
          ApiResponse.completed(User.fromMap(jsonDecode(userString)));
      notifyListeners();
    }
  }
  Future<void> getCurrentUser() async {
    if (currentUserResponse.data == null) {
      currentUserResponse =
          ApiResponse.loading(message: 'fetching user data...');
    } else {
      currentUserResponse = ApiResponse.more(
          message: 'fetching user data...', data: currentUserResponse.data);
    }
    notifyListeners();
    try {
      final User user = await _repository.getCurrentUser();
      SharedHelper shared = SharedHelper();
      await shared.saveData(key: 'user', value: jsonEncode(user.toMap()));

      currentUserResponse = ApiResponse.completed(user,
          message: 'user data fetched successfully');
      notifyListeners();
    } catch (e) {
      currentUserResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> updateUser(String name, {String? imagePath}) async {
    currentUserResponse = ApiResponse.more(
        message: 'updating user data...', data: currentUserResponse.data);
    notifyListeners();
    try {
      final User user = await _repository.updateUser(name, imagePath);
      SharedHelper shared = SharedHelper();
      await shared.saveData(key: 'user', value: jsonEncode(user.toMap()));

      currentUserResponse = ApiResponse.completed(user,
          message: 'user data updated successfully');
      notifyListeners();
    } catch (e) {
      currentUserResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> logout() async {
    currentUserResponse = ApiResponse.loading(message: 'logging out...');
    notifyListeners();
    try {
      final response = await _repository.logout();
      SharedHelper shared = SharedHelper();
      await shared.removeData(key: 'user');
      await shared.removeData(key: 'token');

      currentUserResponse = ApiResponse.completed(null,
          message: response['response'] ?? 'logout completed');
      notifyListeners();
    } catch (e) {
      currentUserResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
