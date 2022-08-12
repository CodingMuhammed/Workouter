import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/Ui/global.dart';
import 'package:workout_app/Ui/workout_page.dart';

final GlobalKey<FormState> _key = GlobalKey<FormState>();
Future<void> ConfirminationDialog(
    BuildContext context, _data, index, snapshot) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Do you want to delete the exercise',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            OutlinedButton(
              child: Text('Yes', style: TextStyle(color: Colors.white)),
              onPressed: () {
                FirebaseFirestore.instance
                    .runTransaction((Transaction myTransaction) async {
                  myTransaction.delete(_data.docs[index].reference);
                });
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(backgroundColor: Colors.blue),
            ),
            OutlinedButton(
              child: Text('No', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      });
}
