import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../models/todo.dart';
import '../services/todo_services.dart';

class TodoPage extends StatelessWidget {
  TodoPage({
    super.key,
    this.todo,
  }) {
    if (todo != null) {
      heading = 'Update Todo';
      buttonText = 'Update';
      _titleController.text = todo!.title;
      _contentController.text = todo!.content!;
    } else {
      heading = 'Add Todo';
      buttonText = 'Add';
    }
  }

  final _tdFormKey = GlobalKey<FormState>();
  final Todo? todo;

  late String heading;

  late String buttonText;
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _tdFormKey,
      child: Scaffold(
        backgroundColor: tdBGColor,
        appBar: AppBar(
          backgroundColor: tdBGColor,
          title: Text(heading),
          actions: [
            TextButton(
              onPressed: () {
                if (!_tdFormKey.currentState!.validate()) {
                  //  log('failed');
                  return;
                }
                _tdFormKey.currentState!.save();

                if (todo == null) {
                  TodoService.to.addTodo(
                    title: _titleController.text,
                    content: _contentController.text,
                  );
                } else {
                  TodoService.to.updateTodo(
                    id: todo!.id,
                    title: _titleController.text,
                    content: _contentController.text,
                  );
                }
              },
              child: Text(buttonText),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                validator: (va) {
                  if (va!.isEmpty) {
                    return "Title must not be empty".tr;
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter title',
                  labelText: 'Title',
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: tdWhite,
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                textAlignVertical: TextAlignVertical.top,
              ),
              const SizedBox(height: 26),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'Enter content',
                  labelText: 'Content',
                  alignLabelWithHint: true,
                  filled: true,
                  fillColor: tdWhite,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                // minLines: null,
                textAlignVertical: TextAlignVertical.top,
                //expands: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*void openTodoDialog({
  required BuildContext context,
  required String id,
  required String title,
  String? content,
}) {
  String title = id.isEmpty ? 'Add Todo' : 'Update Todo';
  String buttonText = id.isEmpty ? 'Add' : 'Update';
  final TextEditingController _titleController =
      TextEditingController(text: title);
  final TextEditingController _contentController =
      TextEditingController(text: content);
  Get.defaultDialog(
    title: title,
    content: Card(
      child: ListView(
        shrinkWrap: true,
        children: [
          Expanded(
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
          SizedBox(
            height: Get.height * 0.5,
            width: Get.width,
            child: TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              // maxLines: null,
              //minLines: null,
              textAlignVertical: TextAlignVertical.top,
              // expands: true,
            ),
          ),
        ],
      ),
    ),
    */ /* actions: [
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
              title: _titleController.text,
              content: _contentController.text,
            );
          } else {
            TodoService.to.updateTodo(
              id: id,
              title: _titleController.text,
              content: _contentController.text,
            );
          }
        },
        child: Text(buttonText),
      ),
    ],*/ /*
  );
}*/
