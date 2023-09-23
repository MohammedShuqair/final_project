import 'package:final_project/features/mail/models/activity.dart';
import 'package:final_project/features/mail/models/attachment.dart';
import 'package:final_project/features/sender/models/sender.dart';
import 'package:final_project/features/status/models/status.dart';
import 'package:final_project/features/tag/models/tag.dart';

class Mail {
  int? id;
  String? subject;
  String? description;
  String? senderId;
  String? archiveNumber;
  String? archiveDate;
  String? decision;
  String? statusId;
  String? finalDecision;
  String? createdAt;
  String? updatedAt;
  Sender? sender;
  Status? status;
  List<Tag>? tags;
  List<Attachment>? attachments;
  List<Activity>? activities;
  @override
  String toString() {
    return 'Mail{id: $id, subject: $subject, description: $description, senderId: $senderId, archiveNumber: $archiveNumber, archiveDate: $archiveDate, decision: $decision, statusId: $statusId, finalDecision: $finalDecision, createdAt: $createdAt, updatedAt: $updatedAt, sender: $sender, status: $status, tags: $tags, attachments: $attachments, activities: $activities}';
  }

  Mail(
      {this.id,
      this.subject,
      this.description,
      this.senderId,
      this.archiveNumber,
      this.archiveDate,
      this.decision,
      this.statusId,
      this.finalDecision,
      this.createdAt,
      this.updatedAt,
      this.sender,
      this.status,
      this.tags,
      this.attachments,
      this.activities});

  Mail.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    description = json['description'];
    senderId = json['sender_id'];
    archiveNumber = json['archive_number'];
    archiveDate = json['archive_date'];
    decision = json['decision'];
    statusId = json['status_id'];
    finalDecision = json['final_decision'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sender = json['sender'] != null ? Sender.fromMap(json['sender']) : null;
    status = json['status'] != null ? Status.fromMap(json['status']) : null;
    if (json['tags'] != null) {
      tags = <Tag>[];
      json['tags'].forEach((v) {
        tags!.add(Tag.fromMap(v));
      });
    }
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      json['attachments'].forEach((v) {
        attachments!.add(Attachment.fromMap(v));
      });
    }
    if (json['activities'] != null) {
      activities = <Activity>[];
      json['activities'].forEach((v) {
        activities!.add(Activity.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['description'] = description;
    data['sender_id'] = senderId;
    data['archive_number'] = archiveNumber;
    data['archive_date'] = archiveDate;
    data['decision'] = decision;
    data['status_id'] = statusId;
    data['final_decision'] = finalDecision;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (sender != null) {
      data['sender'] = sender!.toMap();
    }
    if (status != null) {
      data['status'] = status!.toMap();
    }
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toMap()).toList();
    }
    data['attachments'] = attachments;
    if (activities != null) {
      data['activities'] = activities!.map((v) => v.toMap()).toList();
    }
    return data;
  }

  static List<Mail> mapValueToList(List? response) {
    List<Mail> mails = [];
    if (response != null) {
      response.forEach((v) {
        mails.add(Mail.fromMap(v));
      });
    }
    return mails;
  }
}
