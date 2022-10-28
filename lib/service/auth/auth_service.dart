import 'package:workouter/ui/workout/workout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;


  Future<User?> logIn({required String email, required String password, context}) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) => _navigateToHome(context));
    } on FirebaseAuthException catch (e) {
      _showSnackBar(context, e);
    }
  }

  Future<User?> signUp(
      {required String email,
      required String password,
      required String confirm,
      context}) async {
    if (password == confirm) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((_) => _navigateToHome(context));
      } on FirebaseAuthException catch (e) {
        _showSnackBar(context, e);
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void _showSnackBar(context, error) {
    SnackBar snackBar = SnackBar(
          content: Text(error.message.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _navigateToHome(context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const WorkoutPage()));
  }
}
