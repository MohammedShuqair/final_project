import 'dart:convert';

import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/data/local/local_pref.dart';
import 'package:final_project/features/auth/model/user_response.dart';
import 'package:final_project/features/auth/reop/auth_repository.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository _repository;
  late ApiResponse<UserResponse> loginResponse;
  late ApiResponse<UserResponse> registerResponse;
  AuthProvider() {
    _repository = AuthRepository();
  }
  Future<void> loginUser(String email, String password) async {
    loginResponse = ApiResponse.loading('logging...');
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
          ApiResponse.completed(user, 'login completed successfully');
      notifyListeners();
    } catch (e, s) {
      loginResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  void registerUser({
    required String email,
    required String name,
    required String password,
    required String passwordConfirmation,
  }) async {
    registerResponse = ApiResponse.loading('registering...');
    notifyListeners();
    try {
      final UserResponse user = await _repository.register(
          email, name, password, passwordConfirmation);
      registerResponse =
          ApiResponse.completed(user, 'register completed successfully');
      notifyListeners();
    } catch (e) {
      registerResponse = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
