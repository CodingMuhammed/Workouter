import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/Ui/global.dart';
import 'package:workout_app/Ui/workout_page.dart';

final GlobalKey<FormState> _key = GlobalKey<FormState>();
Future<void> ExerciseDialog(
    BuildContext context, exerciseNameController, exerciseData) {
  return showDialog(
      barrierDismissible: firstLoad ?? true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Text('Exercise Name'),
          content: Form(
            key: _key,
            child: TextFormField(
              controller: exerciseNameController,
            ),
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
                      if (exerciseNameController.text != '' ||
                          exerciseNameController.text != null) {
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('workout')
                            .add({
                          'exerciseName': exerciseNameController.text,
                          'reps': 0.toString(),
                          'sets': 0.toString(),
                          'weight': 0.0.toString(),
                          'rest': 0.0.toString()
                        });
                        exerciseNameController.clear();
                        Navigator.pop(context);
                      } else {
                        return null;
                      }
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
