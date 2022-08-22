import 'package:Workouter/Ui/workout_page.dart';
import 'package:Workouter/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // Login Function
  static Future<User?> logInMethod(
      {required String email, required String password, context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((_) => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => WorkoutPage())));
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar2 = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
    return null;
  }

  // Sign up function
  static Future<User?> signupMethod(
      {required String email, password, confirm, context}) async {
    try {
      password == confirm
          ? await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((_) => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WorkoutPage())))
          : null;
    } on FirebaseAuthException catch (e) {
      SnackBar snackBar1 = SnackBar(
        content: Text(e.message.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    }
    return null;
  }

  // SignOut function
  static Future<User?> signOutMethod() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
    return null;
  }
}
