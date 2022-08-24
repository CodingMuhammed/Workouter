import 'package:Workouter/Ui/dialog_instance.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Workouter/Models/exercise.dart';

class ExerciseCard extends StatefulWidget {
  Exercise? exerciseData;
  final snapshot;
  final index;
  ExerciseCard(this.snapshot, this.index, exerciseData, {Key? key})
      : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

String deleteExerciseText = 'Delete exercise';
final uid = FirebaseAuth.instance.currentUser?.uid;
late TextEditingController _setsController;
late TextEditingController _repsController;
late TextEditingController _weightController;
late TextEditingController _restController;

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
    final data = widget.snapshot.data;
    final documentId = data.docs[widget.index].reference.id;
    void deleteExerciseFunction() {
      FirebaseFirestore.instance
          .runTransaction((Transaction myTransaction) async {
        myTransaction.delete(data.docs[widget.index].reference);
      });
      Navigator.pop(context);
    }

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
                      data.docs[widget.index]['exerciseName'],
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
                        DialogInstance(context, deleteExerciseFunction, deleteExerciseText);
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
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('workout')
                                  .doc(documentId)
                                  .update({'reps': value});
                            });
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _repsController,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText:
                                  data.docs[widget.index]['reps'].toString()),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('workout')
                                  .doc(documentId)
                                  .update({'sets': value});
                            });
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _setsController,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText:
                                  data.docs[widget.index]['sets'].toString()),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('workout')
                                  .doc(documentId)
                                  .update({'weight': value});
                            });
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _weightController,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText:
                                  data.docs[widget.index]['weight'].toString()),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('workout')
                                  .doc(documentId)
                                  .update({'rest': value});
                            });
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _restController,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText:
                                  data.docs[widget.index]['rest'].toString()),
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
