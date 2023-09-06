// To parse this JSON data, do
//
//     final attachment = attachmentFromMap(jsonString);

import 'dart:convert';

Attachment attachmentFromMap(String str) =>
    Attachment.fromMap(json.decode(str));

String attachmentToMap(Attachment data) => json.encode(data.toMap());

class Attachment {
  int? id;
  String? title;
  String? image;
  String? mailId;
  String? createdAt;
  String? updatedAt;

  Attachment({
    this.id,
    this.title,
    this.image,
    this.mailId,
    this.createdAt,
    this.updatedAt,
  });

  factory Attachment.fromMap(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        mailId: json["mail_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "image": image,
        "mail_id": mailId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
  @override
  String toString() {
    return 'Attachment{id: $id, title: $title, image: $image, mailId: $mailId, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
