import 'package:flutter/material.dart';
import 'package:workout_app/workout.dart';

final newWorkout = Workout(null, null, null, null, null);

final myGradient = BoxDecoration(
  border: Border.all(color: Colors.white),
  borderRadius: BorderRadius.circular(32),
  gradient: const LinearGradient(colors: [
    Colors.blue,
    Color.fromARGB(255, 70, 93, 105)
  ]),
);
const backgroundColor = Color.fromARGB(255, 70, 93, 105);
final buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.transparent, shadowColor: Colors.transparent);

