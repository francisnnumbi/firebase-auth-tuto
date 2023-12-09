import 'package:firebase_auth_tuto/api/firebase_api.dart';
import 'package:firebase_auth_tuto/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/todo.dart';

class TodoService extends GetxService {
  // ------- static methods ------- //
  static TodoService get to => Get.find();

  static Future<void> init() async {
    await Get.putAsync<TodoService>(() async => TodoService());
  }

// ------- ./static methods ------- //

  final RxList<Todo> todos = <Todo>[].obs;
  final RxString searchQuery = ''.obs;

  List<Todo> get filteredTodos {
    return searchQuery.value.isEmpty
        ? todos
        : todos
            .where(
              (Todo todo) => todo.todoText.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
            )
            .toList();
  }

  Future<void> initializeBindings() async {
    todos.bindStream(FirebaseApi.readTodos());
  }

  Future<void> clearBindings() async {
    todos.clear();
  }

  Future<void> dispose() async {
    await clearBindings();
    await Get.delete(force: true);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void addTodo({
    required String content,
  }) {
    FirebaseApi.createTodo(content: content);
  }

  void filterTodos(String query) {
    searchQuery.value = query.trim();
    todos.refresh();
  }

  void clearFilterTodos() {
    searchQuery.value = '';
    todos.refresh();
  }

  void updateTodo({
    required String id,
    required String content,
  }) {
    final Todo todo = todos.firstWhere((Todo todo) => todo.id == id);
    todo.todoText = content;
    FirebaseApi.updateTodo(todo);
  }

  void toggleTodoStatus(String id) {
    final Todo todo = todos.firstWhere((Todo todo) => todo.id == id);
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
  }

  void deleteTodoById(String id) {
    Get.defaultDialog(
      title: 'Delete Todo',
      middleText: 'Are you sure you want to delete this todo?',
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            final Todo todo = todos.firstWhere((Todo todo) => todo.id == id);
            FirebaseApi.deleteTodo(todo);
          },
          style: TextButton.styleFrom(
            foregroundColor: tdRed,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
