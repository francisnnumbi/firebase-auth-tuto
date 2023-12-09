import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../services/todo_services.dart';

class SearchTodo extends StatelessWidget {
  SearchTodo({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          TodoService.to.filterTodos(searchController.text);
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 25, minHeight: 20),
          border: InputBorder.none,
          hintText: 'Search Todo',
          hintStyle: const TextStyle(
            color: tdGrey,
          ),
          suffixIcon: Obx(() {
            return IconButton(
              onPressed: TodoService.to.searchQuery.isEmpty
                  ? null
                  : () {
                      searchController.clear();
                      TodoService.to.clearFilterTodos();
                    },
              icon: TodoService.to.searchQuery.isEmpty
                  ? const SizedBox()
                  : const Icon(Icons.close),
              color: tdGrey,
              iconSize: 20,
            );
          }),
        ),
      ),
    );
  }
}
