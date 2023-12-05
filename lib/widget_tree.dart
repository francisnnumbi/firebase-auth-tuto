import 'package:firebase_auth_tuto/auth.dart';
import 'package:firebase_auth_tuto/pages/home_page.dart';
import 'package:firebase_auth_tuto/pages/login_register_page.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return const LoginPage();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
