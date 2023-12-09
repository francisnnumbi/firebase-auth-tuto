import 'dart:developer';

import 'package:firebase_auth_tuto/services/todo_services.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  Widget _entryField({
    required String title,
    required TextEditingController controller,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, right: 20, left: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: tdWhite,
        boxShadow: const [
          BoxShadow(
            color: tdGrey,
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          filled: true,
          fillColor: tdWhite,
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _entryField(
          title: "enter title",
          controller: titleController,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _entryField(
            title: "enter content",
            controller: contentController,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            bottom: 20,
            right: 20,
          ),
          child: ElevatedButton(
            onPressed: () {
              log("add todo button pressed");
              if (titleController.text.isNotEmpty) {
                TodoService.to.addTodo(
                  title: titleController.text,
                  content: contentController.text,
                );
                // clear text field
                titleController.clear();
                contentController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: tdBlue,
              minimumSize: const Size(50, 50),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: const Text(
              "+",
              style: TextStyle(
                fontSize: 40,
                color: tdWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
