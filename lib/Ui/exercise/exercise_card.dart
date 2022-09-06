import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workouter/Ui/exercise/cardiovascular_card.dart';
import 'package:workouter/Ui/exercise/strength_card.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Ui/exercise/exercise_type_dialog.dart';

class ExerciseCard extends StatefulWidget {
  AsyncSnapshot<QuerySnapshot> snapshot;
  int index;
  ExerciseCard(this.snapshot, this.index, {Key? key}) : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    final data = widget.snapshot.data;

    if (data!.docs[widget.index]['exerciseType'] == strength) {
      return StrengthCard(widget.snapshot, widget.index);
    } else if (data.docs[widget.index]['exerciseType'] == cardiovascualar) {
      return CardiovascularCard(widget.snapshot, widget.index);
    } else {
      Future.delayed(Duration.zero, () => ExerciseTypeDialog(context));
      return const SizedBox(height: 0.0);
    }
  }
}
