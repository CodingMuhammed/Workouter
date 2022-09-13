import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/Models/cardiovascular_exercise.dart';
import 'package:workouter/Models/strength_exercise.dart';
import 'package:workouter/Ui/exercise/cardiovascular_card.dart';
import 'package:workouter/Ui/exercise/strength_card.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Ui/exercise/exercise_type_dialog.dart';

class ExerciseCard extends StatefulWidget {
  AsyncSnapshot<QuerySnapshot> snapshot;
  int index;
  bool? firstLoad;
  CardiovascularExercise? cardiovascularExercise;
  StrengthExercise? strengthExercise;

  ExerciseCard(this.snapshot, this.index, this.firstLoad,
      this.cardiovascularExercise, this.strengthExercise,
      {Key? key})
      : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    final data = widget.snapshot.data;

    if (data!.docs[widget.index]['type'] == strength) {
      return StrengthCard(widget.snapshot, widget.index, widget.strengthExercise);
    } else if (data.docs[widget.index]['type'] == cardiovascualar) {
      return CardiovascularCard(widget.snapshot, widget.index, widget.cardiovascularExercise);
    } else {
      Future.delayed(
          Duration.zero, () => ExerciseTypeDialog(context, widget.firstLoad));
      return const SizedBox(height: 0.0);
    }
  }
}
