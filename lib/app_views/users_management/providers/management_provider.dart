import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/auth/model/role.dart';
import 'package:final_project/features/user_management/repo.dart';
import 'package:flutter/material.dart';

class ManagementProvider extends ChangeNotifier {
  ApiResponse<List<Role>>? allRoles;
  ApiResponse<String>? deleteResponse;
  UserManagementRepository repository = UserManagementRepository();
  String? searchFor;

  ManagementProvider() {
    init();
  }
  void reset() {
    searchFor = null;
    allRoles?.data = null;
    init();
  }

  Future<void> init() async {
    if (searchFor == null) {
      await getAllRoles();
    } else {
      await search(searchFor!);
    }
  }

  Future<void> search(String value) async {
    searchFor = value.trim().toLowerCase();
    if (allRoles?.data == null) {
      allRoles = ApiResponse.loading(message: 'logging...');
    } else {
      allRoles = ApiResponse.more(message: 'logging...', data: allRoles?.data);
    }
    try {
      final List<Role> roles = await repository.getRoles();
      roles.forEach((role) {
        role.users?.removeWhere((user) =>
            !((user.name?.trim().toLowerCase().contains(searchFor!) ?? false) ||
                (user.email?.toLowerCase().contains(searchFor!) ?? false)));
      });
      roles.removeWhere((role) => role.users?.isEmpty ?? true);
      allRoles =
          ApiResponse.completed(roles, message: 'Roles fetched successfully');
      notifyListeners();
    } catch (e) {
      allRoles = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> getAllRoles() async {
    if (allRoles?.data == null) {
      allRoles = ApiResponse.loading(message: 'logging...');
    } else {
      allRoles = ApiResponse.more(message: 'logging...', data: allRoles?.data);
    }
    notifyListeners();
    try {
      final List<Role> roles = await repository.getRoles();
      allRoles =
          ApiResponse.completed(roles, message: 'Roles fetched successfully');
      notifyListeners();
    } catch (e) {
      allRoles = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> deleteUser(int uid) async {
    deleteResponse = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final String message = await repository.deleteUser(uid);
      deleteResponse = ApiResponse.completed(message, message: message);
      notifyListeners();
    } catch (e) {
      deleteResponse = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
