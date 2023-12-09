import 'package:firebase_auth_tuto/models/todo.dart';
import 'package:firebase_auth_tuto/services/todo_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../constants/colors.dart';
import '../constants/settings.dart';
import '../pages/todo_page.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return buildMain;
  }

  Container get buildMain {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: tdWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Slidable(
        groupTag: todo.id,
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                if (kDebugMode) {
                  print("tile edit tapped");
                }
                openTodoDialog(
                    context: context, id: todo.id, content: todo.todoText);
              },
              backgroundColor: tdBlue,
              icon: Icons.edit,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.25,
          children: [
            SlidableAction(
              onPressed: (context) {
                if (kDebugMode) {
                  print("tile edit tapped");
                }
                TodoService.to.deleteTodoById(todo.id);
              },
              backgroundColor: tdRed,
              icon: Icons.delete,
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 5),
          horizontalTitleGap: 2,

          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: tdBlue,
          ),
          //Checkbox(value: todo.isDone, onChanged: (value) {}),
          tileColor: tdWhite,
          title: Text(
            todo.todoText,
            //  maxLines: 2,
            // softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          onTap: () {
            if (kDebugMode) {
              print("tile tapped");
            }
            //TodoService.to.toggleTodoStatus(todo.id);
          },
          onLongPress: () {
            if (kDebugMode) {
              print("tile long pressed");
            }
            TodoService.to.toggleTodoStatus(todo.id);
          },

          /*trailing: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(vertical: 6),
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: tdRed,
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              onPressed: () {
                if (kDebugMode) {
                  print("tile delete tapped");
                }
                TodoService.to.deleteTodoById(todo.id);
              },
              color: tdWhite,
              iconSize: 18,
              icon: const Icon(Icons.delete),
            ),
          ),*/
        ),
      ),
    );
  }
}
