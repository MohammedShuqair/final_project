class MailStatus {
  int? id;
  String? name;
  String? color;

  MailStatus({this.id, this.name, this.color});

  MailStatus.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['color'] = color;
    return data;
  }
}
