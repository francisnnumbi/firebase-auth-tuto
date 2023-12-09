import 'package:faker/faker.dart';
import 'package:firebase_auth_tuto/constants/colors.dart';
import 'package:firebase_auth_tuto/generated/assets.dart';
import 'package:firebase_auth_tuto/models/todo.dart';
import 'package:firebase_auth_tuto/pages/todo_page.dart';
import 'package:firebase_auth_tuto/services/todo_services.dart';
import 'package:firebase_auth_tuto/widgets/add_todo.dart';
import 'package:firebase_auth_tuto/widgets/search_todo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tuto/auth.dart';
import 'package:get/get.dart';

import '../widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _subTitle() {
    return const Text(
      'All ToDos',
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
    );
  }

  Widget _userUid() {
    return Text(user?.email ?? 'User email');
  }

  Widget _userAvatar() {
    return const CircleAvatar(
      backgroundImage: AssetImage(
        Assets.imagesAvatar1,
      ),
    );
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text("Sign out"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: tdBlue,
        foregroundColor: tdWhite,
        onPressed: () {
          openTodoDialog(context: context, id: '', content: '');
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          children: [
            SearchTodo(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Obx(() {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 50.0, bottom: 20.0),
                          child: _subTitle(),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Todo item = TodoService.to.filteredTodos[index];
                            return TodoItem(todo: item);
                          },
                          childCount: TodoService.to.filteredTodos!.length,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            //AddTodo(),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: tdBGColor,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
                // color: tdGrey,
                ),
            child: Column(
              children: [
                _userUid(),
                const Spacer(),
                _signOutButton(),
              ],
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      actions: [
        _userAvatar(),
        const SizedBox(width: 10),
      ],
    );
  }
}
