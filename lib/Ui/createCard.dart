import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Widget CreateCard(
    BuildContext context,
    AsyncSnapshot<QuerySnapshot> snapshot,
    index,
    users,
    repsController,
    setsController,
    weightController,
    restController,
    _focusNode,
    _hint,
    exerciseData) {
  final _data = snapshot.requireData;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(children: [
      Card(
        color: const Color.fromARGB(255, 81, 108, 122),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _data.docs[index]['exerciseName'],
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  'Reps',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Sets',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Weight',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'rest',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            //
            Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      FirebaseFirestore.instance
                          .runTransaction((Transaction myTransaction) async {
                        myTransaction.delete(_data.docs[index].reference);
                      });
                    },
                    label: 'Delete',
                    backgroundColor: Colors.red,
                    icon: Icons.delete,
                  )
                ],
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 25,
                        child: TextField(
                          // focusNode: _focusNode,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: repsController,
                          decoration: InputDecoration(hintText: _hint ?? 0.toString()),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 0.toString(),
                          ),
                          textAlign: TextAlign.center,
                          controller: setsController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              {exerciseData.sets = int.parse(value)},
                        ),
                      ),
                      SizedBox(
                        width: 25,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 0.0.toString(),
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          onChanged: (value) =>
                              {exerciseData.weight = double.parse(value)},
                        ),
                      ),
                      SizedBox(
                        width: 25,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 0.0.toString(),
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: restController,
                          onChanged: (value) =>
                              {exerciseData.rest = double.parse(value)},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}
