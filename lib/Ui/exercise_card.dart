import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_app/Models/exercise.dart';
import 'package:workout_app/Ui/delete_dialog.dart';

final uid = FirebaseAuth.instance.currentUser!.uid;

class ExerciseCard extends StatefulWidget {
  Exercise? exerciseData;
  final snapshot;
  final index;
  ExerciseCard(this.snapshot, this.index, exerciseData);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

late TextEditingController _setsController;
late TextEditingController _weightController;
late TextEditingController _restController;
late TextEditingController _repsController;

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  void initState() {
    _repsController = TextEditingController();
    _setsController = TextEditingController();
    _weightController = TextEditingController();
    _restController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _data = widget.snapshot.requireData;
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
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 25,
                          child: TextField(
                            onSubmitted: (value) async {
                              final documentId = _data!.reference.id;
                              FirebaseFirestore.instance.runTransaction(
                                  (Transaction myTransaction) async {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .collection('workout')
                                    .doc(documentId)
                                    .update({'reps': _repsController.text});
                              });
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: _repsController,
                            decoration: InputDecoration(
                                hintText: _data.docs[widget.index]['reps']
                                    .toString()),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 0.toString(),
                            ),
                            textAlign: TextAlign.center,
                            controller: _setsController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                {widget.exerciseData!.sets = int.parse(value)},
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
                            controller: _weightController,
                            onChanged: (value) => {
                              widget.exerciseData!.weight = double.parse(value)
                            },
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
                            controller: _restController,
                            onChanged: (value) => {
                              widget.exerciseData!.rest = double.parse(value)
                            },
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
}
