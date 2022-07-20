import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_app/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final GlobalKey<FormState> _key = GlobalKey<FormState>();

Future CreateAlertDialog(
  BuildContext context
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Text('Exercise Name'),
          content: Form(
            key: _key,
            child: TextFormField(
              autofocus: true,
              onChanged: (value) {
              newWorkout.exerciseName = value;
            }),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 44.0,
                decoration: myGradient,
                child: ElevatedButton(
                    onPressed: () async {
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance
                          .collection('userData')
                          .doc(uid)
                          .collection('workout')
                          .add({
                        'exerciseName': newWorkout.exerciseName,
                        'reps': newWorkout.reps,
                        'sets': newWorkout.sets,
                        'weight': newWorkout.weight,
                        'rest': newWorkout.rest
                      });
                      Navigator.pop(context);
                    },
                    style: buttonStyle,
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ],
        );
      });
}
