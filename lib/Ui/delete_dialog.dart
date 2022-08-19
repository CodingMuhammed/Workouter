import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> DeleteDialog(BuildContext context, _data, index, snapshot) {
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
              child: const Text('Yes', style: TextStyle(color: Colors.white)),
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
              child: const Text('No', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      });
}
