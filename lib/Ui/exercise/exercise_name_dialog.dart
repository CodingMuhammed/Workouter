import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/Models/exercise.dart';
import 'package:workouter/widgets/gradient_elevated_button.dart';

TextEditingController exerciseNameController = TextEditingController();
final uid = FirebaseAuth.instance.currentUser?.uid;
Future<void> ExerciseNameDialog(BuildContext context, strength, cardiovascualar,
    firstLoad, exercise) {
  return showDialog(
      barrierDismissible: firstLoad ?? true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Center(
              child:
                  Text('Exercise Name', style: TextStyle(color: Colors.white))),
          content: TextField(
            controller: exerciseNameController,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GradientElevatedButton(
                  width: MediaQuery.of(context).size.width * 0.7,
                  onPressed: () async {
                    _addExercise(context, cardiovascualar, strength, exercise,
                        );
                  },
                  child: const Text(
                    'ADD',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        );
      });
}

_addExercise(
    context, cardiovascualar, strength,Exercise? exercise) {
  if (exercise!.type == strength && exerciseNameController.text.isNotEmpty) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('workouts')
        .add({
      'name': exerciseNameController.text,
      'reps': 0,
      'sets': 0,
      'weight': 0.0,
      'rest': 0.0,
      'type': exercise.type
    });
    // exercise = Exercise(exercise.reps, exercise.sets, exercise.weight,
    //     exercise.name, exercise.rest, exercise.type);
    // exerciseList.add(exercise);
    exerciseNameController.clear();
    Navigator.pop(context);
  } else {
    if (exercise.type == cardiovascualar &&
        exerciseNameController.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('workouts')
          .add({
        'name': exerciseNameController.text,
        'calories_burnt': 0,
        'time': 0.0,
        'type': exercise.type
      });
      // exercise = Exercise(exercise.reps, exercise.sets, exercise.weight,
      //     exercise.name, exercise.rest, exercise.type);
      // exerciseList.add(exercise);
      exerciseNameController.clear();
      Navigator.pop(context);
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text("Text field can't be empty"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
