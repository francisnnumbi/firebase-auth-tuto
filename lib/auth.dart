import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_tuto/main.dart';
import 'package:firebase_auth_tuto/services/todo_services.dart';
import 'package:get/get.dart';

import 'api/firebase_api.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  String get uid => _firebaseAuth.currentUser!.uid;

  CollectionReference<Map<String, dynamic>> get db =>
      FirebaseFirestore.instance.collection(Auth().uid);

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // TodoService.to.initializeBindings();
    await initServices();
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // TodoService.to.initializeBindings();
    await initServices();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    TodoService.to.dispose();
  }
}
