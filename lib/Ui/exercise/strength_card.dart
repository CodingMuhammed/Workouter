import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workouter/Models/exercise.dart';
import 'package:workouter/Ui/global.dart';
import 'package:workouter/widgets/dialog_instance.dart';

class StrengthCard extends StatefulWidget {
  Exercise? exercise;

  StrengthCard(this.exercise, {Key? key}) : super(key: key);

  @override
  State<StrengthCard> createState() => _StrengthCardState();
}

const deleteExerciseText = 'Delete exercise';
const deleteExerciseDescription = 'you want to delete this exercise?';
final uid = FirebaseAuth.instance.currentUser?.uid;
TextEditingController _setsController = TextEditingController();
TextEditingController _repsController = TextEditingController();
TextEditingController _weightController = TextEditingController();
TextEditingController _restController = TextEditingController();

class _StrengthCardState extends State<StrengthCard> {
  @override
  Widget build(BuildContext context) {
    void deleteExercise() {
      FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('workouts')
          .doc(widget.exercise!.id)
          .delete();
      Navigator.pop(context);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        Container(
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(
              color: Colors.blue,
              blurRadius: 20
            )]
          ),
          child: Card(
            color: darkBlueColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.exercise!.name,
                        style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const Divider(thickness: 1.0),
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
                          DialogInstance(context, deleteExercise,
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
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            cursorColor: Colors.white,
                            onSubmitted: (value) async {
                              widget.exercise!.reps = int.parse(value);
                              // FirebaseFirestore.instance.runTransaction(
                              //     (Transaction myTransaction) async {
                              //   FirebaseFirestore.instance
                              //       .collection('users')
                              //       .doc(uid)
                              //       .collection('workouts')
                              //       .doc(exerciseId)
                              //       .update({'reps': value});
                              // });
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: _repsController,
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: widget.exercise!.reps.toString()),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.145,
                          child: TextField(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            cursorColor: Colors.white,
                            onSubmitted: (value) async {
                              widget.exercise!.sets = int.parse(value);
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: _setsController,
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: widget.exercise!.sets.toString()),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.145,
                          child: TextField(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            cursorColor: Colors.white,
                            onSubmitted: (value) async {
                              widget.exercise!.weight = double.parse(value);
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: _weightController,
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: widget.exercise!.weight.toString()),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.145,
                          child: TextField(
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            cursorColor: Colors.white,
                            onSubmitted: (value) async {
                              widget.exercise!.rest = double.parse(value);
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            controller: _restController,
                            decoration: InputDecoration(
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: widget.exercise!.weight.toString(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
