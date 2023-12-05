import 'dart:math';

import 'package:faker/faker.dart';
import 'package:firebase_auth_tuto/constants/colors.dart';
import 'package:firebase_auth_tuto/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tuto/auth.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  final Faker faker = Faker();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

  Widget _subTitle() {
    return const Text(
      'All ToDos',
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
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

  Widget _menuButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu),
    );
  }

  Widget _searchFieldCupertino() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CupertinoSearchTextField(
        controller: searchController,
        decoration: const BoxDecoration(
          color: tdWhite,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        placeholder: 'Search...',
      ),
    );
  }

  Widget _searchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
          color: tdWhite, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(minWidth: 25, minHeight: 20),
          border: InputBorder.none,
          hintText: 'Search...',
          hintStyle: TextStyle(
            color: tdGrey,
          ),
        ),
      ),
    );
  }

  Widget _entryField({
    required String title,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: title,
        filled: true,
        fillColor: tdWhite,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          // borderSide: BorderSide.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: _searchField(),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                      child: _subTitle(),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        var flag = faker.lorem.random.boolean();
                        var txt = faker.lorem.sentence();
                        return Card(
                          color: tdWhite,
                          elevation: 0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading:
                                Checkbox(value: flag, onChanged: (value) {}),
                            title: Text(
                              txt,
                              maxLines: 2,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                decoration:
                                    flag ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            onTap: () {},
                            dense: true,
                            trailing: IconButton(
                              onPressed: () {},
                              color: tdRed,
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        );
                      },
                      childCount: 10,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _entryField(
                      title: "enter todo",
                      controller: textController,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
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
