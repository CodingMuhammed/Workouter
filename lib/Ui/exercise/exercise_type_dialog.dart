import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Ui/exercise/exercise_name_dialog.dart';
import 'package:workouter/Ui/exercise/exercise_page.dart';

TextEditingController exerciseNameController = TextEditingController();
final uid = FirebaseAuth.instance.currentUser?.uid;
String? exerciseType;
String? strength = 'Strength';
String? cardiovascualar = 'Cardiovascular';
Future<void> ExerciseTypeDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: firstLoad ?? true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Center(
              child:
                  Text('Exercise type', style: TextStyle(color: Colors.white))),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            ListTile(
              onTap: () {
                exerciseType = strength;
                Navigator.pop(context);
                Future.delayed(
                    Duration.zero,
                    () => ExerciseNameDialog(
                        context, exerciseType!, strength, cardiovascualar));
              },
              title: Text(
                strength!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              onTap: () {
                exerciseType = cardiovascualar;
                Navigator.pop(context);
                Future.delayed(
                    Duration.zero,
                    () => ExerciseNameDialog(
                        context, exerciseType!, strength, cardiovascualar));
              },
              title: Text(
                cardiovascualar!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold),
              ),
            )
          ]),
        );
      });
}
