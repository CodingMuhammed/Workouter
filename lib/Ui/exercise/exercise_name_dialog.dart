import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/Ui/exercise/exercise_page.dart';
import 'package:workouter/widgets/gradient_elevated_button.dart';

TextEditingController exerciseNameController = TextEditingController();
final uid = FirebaseAuth.instance.currentUser?.uid;
Future<void> ExerciseNameDialog(
    BuildContext context, String exerciseType, strength, cardiovascualar) {
  return showDialog(
      barrierDismissible: firstLoad ?? true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Center(
              child: Text('Exercise Name',
                  style: TextStyle(color: Colors.white))),
          content: TextField(
            controller: exerciseNameController,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GradientElevatedButton(
                width: MediaQuery.of(context).size.width * 0.7,
                  onPressed: () async {
                    if (exerciseType == strength &&
                        exerciseNameController.text.isNotEmpty) {
                      print(exerciseType);
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .collection('workout')
                          .add({
                        'exerciseName': exerciseNameController.text,
                        'reps': 0.toString(),
                        'sets': 0.toString(),
                        'weight': 0.0.toString(),
                        'rest': 0.0.toString(),
                        'exerciseType': exerciseType
                      });
                      exerciseNameController.clear();
                      Navigator.pop(context);
                    } else {
                      if (exerciseType == cardiovascualar &&
                          exerciseNameController.text.isNotEmpty) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .collection('workout')
                            .add({
                          'exerciseName': exerciseNameController.text,
                          'caloriesBurnt': 0,
                          'time': 0.0,
                          'exerciseType': exerciseType
                        });
                        exerciseNameController.clear();
                        Navigator.pop(context);
                      } else {
                        SnackBar snackBar = const SnackBar(
                          content: Text("Text field can't be empty"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
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
