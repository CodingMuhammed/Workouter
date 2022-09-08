import 'package:flutter/material.dart';

Future<void> DialogInstance(BuildContext context, void Function()? function,
    String name, String description) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey,
          title: Text(
            name,
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            Row(
              children: [
                const SizedBox(width: 16.0),
                Text(
                  'Are you sure $description',
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      function;
                    },
                    style:
                        OutlinedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Yes',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
