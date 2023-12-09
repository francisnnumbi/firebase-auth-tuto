import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/todo_services.dart';

void openTodoDialog({
  required BuildContext context,
  required String id,
  required String content,
}) {
  String title = id.isEmpty ? 'Add Todo' : 'Update Todo';
  String buttonText = id.isEmpty ? 'Add' : 'Update';
  final TextEditingController _contentController =
      TextEditingController(text: content);
  Get.defaultDialog(
    title: title,
    content: Expanded(
      child: TextFormField(
        controller: _contentController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
        maxLines: null,
        minLines: null,
        autofocus: true,
        textAlignVertical: TextAlignVertical.top,
        expands: true,
      ),
    ),
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
          if (id == '') {
            TodoService.to.addTodo(
              content: _contentController.text,
            );
          } else {
            TodoService.to.updateTodo(
              id: id,
              content: _contentController.text,
            );
          }
        },
        child: Text(buttonText),
      ),
    ],
  );
}
