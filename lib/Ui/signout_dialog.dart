import 'package:flutter/material.dart';
import 'package:Workouter/authentication/authService.dart';

Future<void> SignoutDialog(BuildContext context) {
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
                AuthService.signOutMethod();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
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
