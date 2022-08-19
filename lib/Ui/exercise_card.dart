import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Workouter/Models/exercise.dart';
import 'package:Workouter/Ui/delete_dialog.dart';

class ExerciseCard extends StatefulWidget {
  Exercise? exerciseData;
  final snapshot;
  final index;
  ExerciseCard(this.snapshot, this.index, exerciseData, {Key? key})
      : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

final uid = FirebaseAuth.instance.currentUser?.uid;
TextEditingController setsController = TextEditingController();
TextEditingController repsController = TextEditingController();
TextEditingController weightController = TextEditingController();
TextEditingController restController = TextEditingController();

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  @override
  Widget build(BuildContext context) {
    final _data = widget.snapshot.data;
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
                      _data.docs[widget.index]['exerciseName'],
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(thickness: 1.0),
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
              Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        DeleteDialog(
                            context, _data, widget.index, widget.snapshot);
                      },
                      label: 'Delete',
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                    )
                  ],
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            final documentId =
                                _data.docs[widget.index].reference.id;
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
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText:
                                  _data.docs[widget.index]['reps'].toString()),
                          onChanged: (value) =>
                              {widget.exerciseData!.reps = int.parse(value)},
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 0.toString(),
                          ),
                          textAlign: TextAlign.center,
                          controller: setsController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              {widget.exerciseData!.sets = int.parse(value)},
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 0.0.toString(),
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: weightController,
                          onChanged: (value) => {
                            widget.exerciseData!.weight = double.parse(value)
                          },
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            focusedBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 0.0.toString(),
                          ),
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: restController,
                          onChanged: (value) =>
                              {widget.exerciseData!.rest = double.parse(value)},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
