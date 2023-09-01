import 'dart:convert';

import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/features/auth/model/user_response.dart';
import 'package:final_project/features/auth/repo/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository _repository;
  late ApiResponse<UserResponse> loginResponse;
  late ApiResponse<UserResponse> registerResponse;
  AuthProvider() {
    _repository = AuthRepository();
  }
  Future<void> loginUser(String email, String password) async {
    loginResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final UserResponse user = await _repository.login(email, password);
      if (user.user != null) {
        SharedHelper shared = SharedHelper();
        shared.setToken(user.token!);
        await shared.saveData(
            key: 'user', value: jsonEncode(user.user!.toJson()));
      }
      loginResponse =
          ApiResponse.completed(user, message: 'login completed successfully');
      notifyListeners();
    } catch (e, s) {
      loginResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> registerUser(
    String email,
    String name,
    String password,
    String passwordConfirmation,
  ) async {
    registerResponse = ApiResponse.loading(message: 'registering...');
    notifyListeners();
    print("here");
    try {
      final UserResponse user = await _repository.register(
          email, name, password, passwordConfirmation);
      registerResponse = ApiResponse.completed(user,
          message: 'register completed successfully');
      notifyListeners();
    } catch (e) {
      registerResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
