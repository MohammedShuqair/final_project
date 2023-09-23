import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/auth/model/role.dart';
import 'package:final_project/features/user_management/repo.dart';
import 'package:flutter/material.dart';

class ManagementProvider extends ChangeNotifier {
  ApiResponse<List<Role>>? allRoles;
  UserManagementRepository repository = UserManagementRepository();
  ManagementProvider() {
    getAllRoles();
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
}
