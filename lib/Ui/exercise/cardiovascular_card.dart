import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/widgets/dialog_instance.dart';

class CardiovascularCard extends StatefulWidget {
  AsyncSnapshot<QuerySnapshot> snapshot;
  int index;
  CardiovascularCard(this.snapshot, this.index, {Key? key}) : super(key: key);

  @override
  State<CardiovascularCard> createState() => _CardiovascularCardState();
}

String deleteExerciseText = 'Delete exercise';
final uid = FirebaseAuth.instance.currentUser?.uid;
TextEditingController _calorieController = TextEditingController();
TextEditingController _timeController = TextEditingController();
String deleteExerciseDescription = 'you want to delete this exercise?';

class _CardiovascularCardState extends State<CardiovascularCard> {
  @override
  Widget build(BuildContext context) {
    String deleteExerciseText = 'Delete exercise';
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final data = widget.snapshot.data;
    final exerciseId = data!.docs[widget.index].reference.id;
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
                    child: Text(data.docs[widget.index]['exerciseName'],
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
                color: Colors.white.withOpacity(0.2),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'Calories',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Time',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Slidable(
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        DialogInstance(context, deleteExerciseFunction,
                            deleteExerciseText, deleteExerciseDescription);
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
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('workout')
                                  .doc(exerciseId)
                                  .update({'caloriesBurnt': value});
                            });
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _calorieController,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: data.docs[widget.index]['caloriesBurnt']
                                  .toString()),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.145,
                        child: TextField(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.cyan),
                          cursorColor: Colors.white,
                          onSubmitted: (value) async {
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction myTransaction) async {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(uid)
                                  .collection('workout')
                                  .doc(exerciseId)
                                  .update({'time': value});
                            });
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          controller: _timeController,
                          decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText:
                                  data.docs[widget.index]['time'].toString()),
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
