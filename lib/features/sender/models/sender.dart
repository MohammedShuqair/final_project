import 'package:final_project/features/category/models/category.dart';
import 'package:final_project/features/mail/models/mail.dart';

class Sender {
  int? id;
  String? name;
  String? mobile;
  String? address;
  String? categoryId;
  String? createdAt;
  String? mailCount;
  String? updatedAt;

  //just id and name of category
  Category? category;
  List<Mail>? mails;

  Sender(
      {this.id,
      this.name,
      this.mobile,
      this.address,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.mailCount,
      this.category,
      this.mails});
  @override
  String toString() {
    return 'Sender {id: $id, name: $name, mobile: $mobile, address: $address, categoryId: $categoryId, createdAt: $createdAt, updatedAt: $updatedAt, mail count: $mailCount, category: $category mails:$mails}';
  }

  static List<Sender> mapValueToList(List? response) {
    List<Sender> senders = [];
    if (response != null) {
      response.forEach((v) {
        senders.add(Sender.fromMap(v));
      });
    }
    return senders;
  }

  Sender.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    mailCount = json['mails_count'];
    category =
        json['category'] != null ? Category.fromMap(json['category']) : null;
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
    data['mobile'] = mobile;
    data['address'] = address;
    data['category_id'] = categoryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['mails_count'] = mailCount;
    if (category != null) {
      data['category'] = category!.toMap();
    }
    if (mails != null) {
      data['mails'] = mails!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
