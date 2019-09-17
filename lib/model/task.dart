import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus { active, done }

class Task {
  String id;
  String title;
  String detail;
  DateTime created;
  DateTime updated;
  DateTime alarm;
  int status;
  Task(
      {this.id,
      this.title,
      this.detail,
      this.created,
      this.updated,
      this.status,
      this.alarm});
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'detail': detail,
      'created': created,
      'updated': created,
      'status': status,
      'alarm': alarm,
    };
  }

  factory Task.fromMap(DocumentSnapshot data) {
    data = data ?? {};
    Timestamp a = data['created'];
    Timestamp b = data['updated'];
    Timestamp c = data['alarm'];

    return Task(
        id: data.documentID,
        title: data['title'],
        detail: data['detail'],
        created: a.toDate(),
        updated: b.toDate(),
        status: data['status'],
        alarm: c==null?null:c.toDate());
  }

  factory Task.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data;
    Timestamp a = data['created'];
    Timestamp b = data['updated'];
    Timestamp c = data['alarm'];
    return Task(
      id: doc.documentID,
      title: data['title'],
      detail: data['detail'],
      created: a.toDate(),
      updated: b.toDate(),
      status: data['status'],
      alarm: c==null?null:c.toDate(),
    );
  }
}
