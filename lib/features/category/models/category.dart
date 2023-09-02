// To parse this JSON data, do
//
//     final category = categoryFromMap(jsonString);

import 'dart:convert';

import 'package:final_project/features/sender/models/sender.dart';

Category categoryFromMap(String str) => Category.fromMap(json.decode(str));

String categoryToMap(Category data) => json.encode(data.toMap());

class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? sendersCount;
  List<Sender>? senders;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.sendersCount,
    this.senders,
  });
  @override
  String toString() {
    return 'Category {id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt, sendersCount: $sendersCount, senders: $senders}';
  }

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        sendersCount: json["senders_count"],
        senders: Sender.mapValueToList(json["senders"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "senders_count": sendersCount,
        "senders":
            senders == null ? [] : List<dynamic>.from(senders!.map((x) => x)),
      };
  static List<Category> mapValueToList(List? response) {
    List<Category> categories = [];
    if (response != null) {
      response.forEach((v) {
        categories.add(Category.fromMap(v));
      });
    }
    return categories;
  }
}
