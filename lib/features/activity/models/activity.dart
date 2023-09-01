import 'package:final_project/features/auth/model/user.dart';

class Activity {
  int? id;
  String? body;
  String? userId;
  String? mailId;
  String? sendNumber;
  String? sendDate;
  String? sendDestination;
  String? createdAt;
  String? updatedAt;
  User? user;

  Activity(
      {this.id,
      this.body,
      this.userId,
      this.mailId,
      this.sendNumber,
      this.sendDate,
      this.sendDestination,
      this.createdAt,
      this.updatedAt,
      this.user});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    userId = json['user_id'];
    mailId = json['mail_id'];
    sendNumber = json['send_number'];
    sendDate = json['send_date'];
    sendDestination = json['send_destination'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['body'] = body;
    data['user_id'] = userId;
    data['mail_id'] = mailId;
    data['send_number'] = sendNumber;
    data['send_date'] = sendDate;
    data['send_destination'] = sendDestination;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}