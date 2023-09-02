import 'package:final_project/features/auth/model/user.dart';

class UserResponse {
  User? user;
  String? token;

  UserResponse({this.user, this.token});

  UserResponse.fromMap(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromMap(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user!.toMap();
    }
    data['token'] = token;
    return data;
  }
}
