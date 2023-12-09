import 'package:firebase_auth_tuto/api/firebase_api.dart';
import 'package:firebase_auth_tuto/auth.dart';
import 'package:firebase_auth_tuto/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/todo.dart';
import '../pages/todo_page.dart';

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
              (Todo todo) => todo.title.toLowerCase().contains(
                    searchQuery.value.toLowerCase(),
                  ),
            )
            .toList();
  }

  openTodo({Todo? todo}) {
    Get.to(() => TodoPage(todo: todo));
  }

  Future<void> initializeBindings() async {
    todos.bindStream(FirebaseApi.readTodos());
  }

  Future<void> clearBindings() async {
    todos.clear();
  }

  Future<void> dispose() async {
    await clearBindings();
    await Get.delete<TodoService>(force: true);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    Auth().authStateChanges.listen((event) {
      if (event == null) {
        dispose();
      } else {
        initializeBindings();
      }
    });
  }

  void addTodo({
    required String title,
    String? content,
  }) {
    FirebaseApi.createTodo(title: title, content: content).then((value) {
      Get.back();
    });
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
    required String title,
    String? content,
  }) {
    final Todo todo = todos.firstWhere((Todo todo) => todo.id == id);
    todo.title = title;
    todo.content = content;
    FirebaseApi.updateTodo(todo).then((value) {
      Get.back();
    });
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
