import 'package:equatable/equatable.dart';
import 'package:final_project/features/category/models/pivot.dart';
import 'package:final_project/features/mail/models/mail.dart';

class Tag extends Equatable {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Mail>? mails;
  Pivot? pivot;
  @override
  String toString() {
    return 'Tag{id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, mails: $mails, pivot: $pivot}';
  }

  @override
  List<Object?> get props => [id, name, createdAt, updatedAt, mails, pivot];
  Tag(
      {this.id,
      this.name,
      this.createdAt,
      this.updatedAt,
      this.mails,
      this.pivot});

  Tag.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mails = json["mails"] == null
        ? []
        : List<Mail>.from(json["mails"]!.map((x) => Mail.fromMap(x)));
    pivot = json['pivot'] != null ? Pivot.fromMap(json['pivot']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['mails'] =
        mails == null ? [] : List<dynamic>.from(mails!.map((x) => x.toMap()));
    if (pivot != null) {
      data['pivot'] = pivot!.toMap();
    }
    return data;
  }

  static List<Tag> mapValueToList(List? response) {
    List<Tag> tags = [];
    if (response != null) {
      response.forEach((v) {
        tags.add(Tag.fromMap(v));
      });
    }
    return tags;
  }
}
