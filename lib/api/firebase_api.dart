import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_tuto/auth.dart';
import 'package:firebase_auth_tuto/constants/utils.dart';

import '../models/todo.dart';

class FirebaseApi {
  static Future<String> createTodo({
    required String title,
    String? content,
  }) async {
    final docTodo = Auth().dbCollection.doc();

    final todo = Todo(
      id: docTodo.id,
      date: DateTime.now(),
      title: title,
      content: content,
      isDone: false,
    );

    await docTodo.set(todo.toJson());

    return docTodo.id;
  }

  static Future updateTodo(Todo todo) async {
    final docTodo = Auth().dbCollection.doc(todo.id);
    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = Auth().dbCollection.doc(todo.id);

    await docTodo.delete();
  }

  static Stream<List<Todo>> readTodos() => Auth()
      .dbCollection
      .orderBy('title', descending: false)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));
}
