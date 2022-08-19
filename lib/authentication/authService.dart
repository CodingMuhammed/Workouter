import 'package:Workouter/Ui/workout_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  // Sign Up Function
  static Future<User?> logInMethod(
      {required String email,
      required String password,
      errorMessage,
      context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const WorkoutPage()));
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    }
    return null;
  }

  // SignUp function
  static Future<User?> signUpMethod(
      {required String email,
      required String password,
      String? errorMessage,
      context}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const WorkoutPage()));
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
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
