import 'package:final_project/core/util/api_response.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/user_management/repo.dart';
import 'package:flutter/foundation.dart';

class GlobalUserProvider extends ChangeNotifier {
  late UserManagementRepository _repository;
  late ApiResponse<User> singleUser;
  late User selectedUser;
  GlobalUserProvider(User user) {
    selectedUser = user;
    singleUser = ApiResponse.completed(selectedUser,
        message: 'User fetched successfully');
    _repository = UserManagementRepository();
  }
  Future<void> getSingleUser() async {
    singleUser = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final User user = await _repository.getSingleUser(selectedUser.id!);
      selectedUser = user;
      singleUser =
          ApiResponse.completed(user, message: 'User fetched successfully');
      notifyListeners();
    } catch (e) {
      singleUser = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> updateUser(String? name, int? roleId) async {
    singleUser = ApiResponse.loading(message: 'logging...');
    notifyListeners();
    try {
      final User user =
          await _repository.updateUser(selectedUser.id!, name, roleId);
      selectedUser = user;
      singleUser = ApiResponse.completed(user,
          message: '${user.name} updated successfully');
      notifyListeners();
    } catch (e) {
      singleUser = ApiResponse.error(message: e.toString());
      notifyListeners();
    }
  }
}
