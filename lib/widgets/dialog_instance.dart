import 'package:flutter/material.dart';

Future<void> DialogInstance(BuildContext context, function, String name) {
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: const [Text('Are you sure?')],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    function;
                  },
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.blue),
                  child:
                      const Text('Yes', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: 5),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(backgroundColor: Colors.red),
                  child:
                      const Text('Cancel', style: TextStyle(color: Colors.white)),
                ),
              ],
            )
          ],
        );
      });
}
