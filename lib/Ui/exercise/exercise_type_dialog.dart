import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Models/exercise.dart';
import 'package:workouter/Ui/exercise/exercise_name_dialog.dart';

TextEditingController exerciseNameController = TextEditingController();
final uid = FirebaseAuth.instance.currentUser?.uid;
String strength = 'Strength';
String cardiovascualar = 'Cardiovascular';
Future<void> ExerciseTypeDialog(
    BuildContext context, firstLoad, Exercise? exercise) {
  return showDialog(
      barrierDismissible: firstLoad ?? true,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child:
                  Text('Exercise type', style: TextStyle(color: Colors.white))),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              onTap: () {
                exercise!.type = strength;
                Navigator.pop(context);
                Future.delayed(
                    Duration.zero,
                    () => ExerciseNameDialog(context, strength, cardiovascualar,
                        firstLoad, exercise));
              },
              title: Text(
                strength,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                exercise!.type = cardiovascualar;
                Navigator.pop(context);
                Future.delayed(
                    Duration.zero,
                    () => ExerciseNameDialog(context, strength, cardiovascualar,
                        firstLoad, exercise));
              },
              title: Text(
                cardiovascualar,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]),
        );
      });
}
