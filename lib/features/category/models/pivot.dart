class Pivot {
  String? mailId;
  String? tagId;

  Pivot({this.mailId, this.tagId});
  @override
  String toString() {
    return "mailId: $mailId, tagId: $tagId";
  }

  Pivot.fromMap(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mail_id'] = mailId;
    data['tag_id'] = tagId;
    return data;
  }
}
