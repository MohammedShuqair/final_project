import 'package:final_project/features/status/models/status.dart';

class StatusResponse {
  List<Status>? statuses;

  StatusResponse({this.statuses});

  StatusResponse.fromJson(Map<String, dynamic> json) {
    if (json['statuses'] != null) {
      statuses = <Status>[];
      json['statuses'].forEach((v) {
        statuses!.add(Status.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (statuses != null) {
      data['statuses'] = statuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
