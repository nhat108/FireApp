import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_task/model/task.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  String userId;
  DatabaseService({@required this.userId});
  final Firestore _db = Firestore.instance;
  //Get a stream of a signle document
  Stream<Task> streamTask(String id) {
    return _db
        .collection(userId)
        .document(id)
        .snapshots()
        .map((snap) => Task.fromMap(snap))
        .take(1);
  }

  //Query a subollection
  Stream<List<Task>> streamTasks(int status) {
    var ref = _db.collection(userId);
    return ref.where('status', isEqualTo: status).snapshots().map((list) =>
        list.documents.map((doc) => Task.fromFireStore(doc)).toList());
  }

  Stream<List<Task>> streamDones(int status) {
    print('streamDones was called');
    var ref = _db.collection(userId);
    return ref.where('status', isEqualTo: status).snapshots().map((list) =>
        list.documents.map((doc) => Task.fromFireStore(doc)).toList());
  }

  Future<void> createNewTask(Task task) {
    return _db.collection(userId).document().setData(task.toMap());
  }

  Future<void> deleteTask(String id) {
    return _db.collection(userId).document(id).delete();
  }

  Future<void> markAsDoneTask(String id) {
    return _db
        .collection(userId)
        .document(id)
        .updateData({'status': TaskStatus.done.index});
  }

  Future<void> updateTask(Task task) {
    return _db.collection(userId).document(task.id).updateData({
      'title': task.title,
      'detail': task.detail,
      'updated': task.updated,
      'alarm': task.alarm,
    });
  }

  Future<void> deleteAllTasks() async{
   deleteDoneTasks(TaskStatus.active.index);
   deleteDoneTasks(TaskStatus.done.index);
  }

  Future<void> deleteDoneTasks(int status) async {
    List<Task> tasks = await streamDones(status).first;
    for (Task task in tasks){
      deleteTask(task.id);
    }
  }
}
