import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> DeleteDialog(BuildContext context, data, index, snapshot) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: const Text(
            'Are you sure?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .runTransaction((Transaction myTransaction) async {
                  myTransaction.delete(data.docs[index].reference);
                });
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('No', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      });
}
