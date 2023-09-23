import 'package:final_project/core/util/api_base_helper.dart';
import 'package:final_project/features/auth/model/role.dart';
import 'package:final_project/features/auth/model/user.dart';
import 'package:final_project/features/auth/model/user_response.dart';
import 'package:final_project/features/auth/repo/auth_repository.dart';

class UserManagementRepository with ApiBaseHelper {
  Future<User> createUser(
    String email,
    String name,
    String password,
    String passwordConfirmation,
    String roleId,
  ) async {
    UserResponse response = await AuthRepository()
        .register(email, name, password, passwordConfirmation);
    return await changeRole(response.user!.id.toString(), roleId);
  }

  Future<User> changeRole(String uid, String roleId) async {
    final response = await put('users/$uid/role', {'role_id': roleId});
    return User.fromMap(response['user']);
  }

  Future<List<Role>> getRoles() async {
    final response = await get('roles');
    List<Role> roles = [];
    if (response['roles'] != null) {
      roles = <Role>[];
      response['roles'].forEach((v) {
        roles.add(Role.fromMap(v));
      });
    }
    return roles;
  }

  Future<String> deleteUser(int id) async {
    final response = await delete('users/$id');
    return response['message'];
  }

  Future<User> getSingleUser(
    int userId,
  ) async {
    final response = await get('users/$userId');
    return User.fromMap(response['user']);
  }

  Future<User> updateUser(int uid, String? name, int? roleId) async {
    late User user;
    if (name != null) {
      final response = await put('users/$uid?name=$name', null);
      user = User.fromMap(response['user']);
    }
    if (roleId != null) {
      user = await changeRole(uid.toString(), roleId.toString());
    }
    return user;
  }
}
