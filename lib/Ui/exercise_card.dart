import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/Ui/confirmination_dialog.dart';

final uid = FirebaseAuth.instance.currentUser!.uid;
Widget ExerciseCard(
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
  Future<String> get_data(DocumentReference ref) async {
    DocumentSnapshot docSnap = await ref.get();
    var doc_id2 = docSnap.reference.id;
    return doc_id2;
  }

  final _data = snapshot.requireData;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(children: [
      Card(
        elevation: 8,
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
                      ConfirminationDialog(context, _data, index, snapshot);
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
                          onSubmitted: (value) async {
                            print('submitted');
                            DocumentReference ref = FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .collection("workout")
                                .doc();
                            // String documentID = await get_data(ref).toString();
                            // print(documentID);
                            // FirebaseFirestore.instance
                            //     .collection('users')
                            //     .doc(uid)
                            //     .collection('workout')
                            //     .doc(documentID)
                            //     .update({'reps': repsController.text});
                            final documentId =
                                snapshot.data!.docs[index].reference.id;
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('workout')
                                  .doc(documentId)
                                  .update({'reps': repsController.text});
                            });
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: repsController,
                          decoration: InputDecoration(
                              hintText: _data.docs[index]['reps'].toString()),
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
