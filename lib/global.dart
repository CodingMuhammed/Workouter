import 'package:flutter/material.dart';
import 'package:workout_app/screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final newWorkout = Workout(null, null, null, null, null);

final myGradient = BoxDecoration(
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(32),
  gradient: const LinearGradient(colors: [
    Color.fromARGB(255, 0, 166, 255),
    Color.fromARGB(255, 70, 93, 105)
  ]),
);
final BackgroundColor = Color.fromARGB(255, 70, 93, 105);
final buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.transparent, shadowColor: Colors.transparent);

