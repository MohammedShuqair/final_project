import 'package:final_project/features/auth/model/role.dart';

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? emailVerifiedAt;
  dynamic roleId;
  String? createdAt;
  String? updatedAt;
  Role? role;
  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, image: $image, emailVerifiedAt: $emailVerifiedAt, roleId: $roleId, createdAt: $createdAt, updatedAt: $updatedAt, role: $role}';
  }

  User(
      {this.id,
      this.name,
      this.email,
      this.image,
      this.emailVerifiedAt,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.role});

  User.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    emailVerifiedAt = json['email_verified_at'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'] != null ? Role.fromMap(json['role']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['email_verified_at'] = emailVerifiedAt;
    data['role_id'] = roleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (role != null) {
      data['role'] = role!.toMap();
    }
    return data;
  }
}
