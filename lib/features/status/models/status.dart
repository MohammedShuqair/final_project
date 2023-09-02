import 'package:final_project/features/mail/models/mail.dart';

class Status {
  int? id;
  String? name;
  String? color;
  String? createdAt;
  String? updatedAt;
  String? mailsCount;
  List<Mail>? mails;

  Status(
      {this.id,
      this.name,
      this.color,
      this.createdAt,
      this.updatedAt,
      this.mailsCount,
      this.mails});

  Status.fromMap(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mailsCount = json['mails_count'];
    if (json['mails'] != null) {
      mails = <Mail>[];
      json['mails'].forEach((v) {
        mails!.add(Mail.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['mails_count'] = mailsCount;
    if (mails != null) {
      data['mails'] = mails!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
