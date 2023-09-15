import 'package:equatable/equatable.dart';
import 'package:final_project/features/auth/model/user.dart';

class Activity extends Equatable {
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

  Activity({
    this.id,
    this.body,
    this.userId,
    this.mailId,
    this.sendNumber,
    this.sendDate,
    this.sendDestination,
    this.createdAt,
    this.updatedAt,
    this.user,
  });
  @override
  String toString() {
    return 'Activity{id: $id, body: $body, userId: $userId, mailId: $mailId, sendNumber: $sendNumber, sendDate: $sendDate, sendDestination: $sendDestination, createdAt: $createdAt, updatedAt: $updatedAt, user: $user}';
  }

  Activity.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    userId = json['user_id'];
    mailId = json['mail_id'];
    sendNumber = json['send_number'];
    sendDate = json['send_date'];
    sendDestination = json['send_destination'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? User.fromMap(json['user']) : null;
  }

  Map<String, dynamic> toMap() {
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
      data['user'] = user!.toMap();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        body,
        userId,
        mailId,
        sendNumber,
        sendDate,
        sendDestination,
        createdAt,
        updatedAt,
        user,
      ];
}
