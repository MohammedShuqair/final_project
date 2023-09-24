import 'package:final_project/features/auth/model/user.dart';

class Role {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<User>? users;

  Role({this.id, this.name, this.createdAt, this.updatedAt, this.users});

  Role.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(User.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (users != null) {
      data['users'] = users!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
