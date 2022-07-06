import 'package:flutter/material.dart';
import 'package:workout_app/screens/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_app/authService.dart';
import 'package:workout_app/global.dart';
import 'package:workout_app/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final newWorkout = Workout(null, null, null, null, null);
final GlobalKey<FormState> _key = GlobalKey<FormState>();

final linearColor = BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      gradient: const LinearGradient(colors: [
                        Color.fromARGB(255, 0, 166, 255),
                        Color.fromARGB(255, 70, 93, 105)
                      ])
                      );
final BackgroundColor = Color.fromARGB(255, 70, 93, 105);
final buttonStyle = ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    primary: Colors.transparent,
                    shadowColor: Colors.transparent);
Future createAlertDialog(BuildContext context, ) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blueGrey,
              title: const Text('Exercise Name'),
              content: Form(
                key: _key,
                child: TextFormField(onChanged: (value) {
                  newWorkout.exerciseName = value;
                }),
              ),
              actions: [
                Container(
                  decoration: linearColor,
                  child: ElevatedButton(
                    onPressed: () async {
                      String uid =
                          FirebaseAuth.instance.currentUser!.uid.toString();
                      FirebaseFirestore.instance.collection('userData').doc(uid).collection('workout').add({
                        'exerciseName': newWorkout.exerciseName,
                        'reps': newWorkout.reps,
                        'sets': newWorkout.sets,
                        'weight': newWorkout.weight,
                        'rest': newWorkout.rest
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text('Add'),
                  ),
                ),
              ],
            );
          });
    }