import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Workouter/Ui/global.dart';
import 'package:Workouter/Ui/exercise_page.dart';

TextEditingController exerciseNameController = TextEditingController();
final uid = FirebaseAuth.instance.currentUser?.uid;
const IconData fitnessCenter = IconData(0xe28d, fontFamily: 'MaterialIcons');
Future<void> ExerciseDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: firstLoad ?? true,
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Text('Add Exercise'),
          content: TextField(
            controller: exerciseNameController,
          ),
          actions: [
            ExpansionTile(
              leading: const Icon(fitnessCenter),
              title: Text('Strength'),
              children: [
                ListTile(
                  onTap: () {},
                  title: Text('CardioVascular'),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 44.0,
                decoration: myGradient,
                child: ElevatedButton(
                    onPressed: () async {
                      if (exerciseNameController.text.isNotEmpty) {
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
                        return;
                      }
                    },
                    style: buttonStyle,
                    child: const Text(
                      'ADD',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ],
        );
      });
}
