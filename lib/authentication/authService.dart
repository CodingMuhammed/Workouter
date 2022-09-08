import 'package:workouter/Ui/workout/workout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // Login Function
  static Future<User?> signInMethod(
      {required String email, required String password, context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const WorkoutPage())));
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // Sign up function
  static Future<User?> signUpMethod(
      {required String email,
      required String password,
      required String confirm,
      context}) async {
    if (password == confirm) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((_) => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const WorkoutPage())));
      } on FirebaseAuthException catch (e) {
        SnackBar snackBar = SnackBar(
          content: Text(e.message.toString()),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  // SignOut function
  static Future<User?> signOutMethod() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }
}
