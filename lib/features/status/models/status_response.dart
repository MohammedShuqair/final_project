import 'package:final_project/features/status/models/status.dart';

class StatusResponse {
  List<Status>? statuses;

  StatusResponse({this.statuses});

  StatusResponse.fromMap(Map<String, dynamic> json) {
    if (json['statuses'] != null) {
      statuses = <Status>[];
      json['statuses'].forEach((v) {
        statuses!.add(Status.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (statuses != null) {
      data['statuses'] = statuses!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}
