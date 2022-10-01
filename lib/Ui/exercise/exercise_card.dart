import 'package:workouter/Models/exercise.dart';
import 'package:workouter/Ui/exercise/cardiovascular_card.dart';
import 'package:workouter/Ui/exercise/strength_card.dart';
import 'package:flutter/material.dart';
import 'package:workouter/Ui/exercise/exercise_type_dialog.dart';

class ExerciseCard extends StatefulWidget {
  bool? firstLoad;
  Exercise? exercise;
  List exerciseList;

  ExerciseCard(this.firstLoad, this.exercise, this.exerciseList, {Key? key})
      : super(key: key);

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.exercise!.type == strength) {
      return StrengthCard(widget.exercise);
    } else if (widget.exercise!.type == cardiovascualar) {
      return CardiovascularCard(widget.exercise);
    } else {
      Future.delayed(
          Duration.zero,
          () => ExerciseTypeDialog(
              context, widget.firstLoad, widget.exercise));
      return const SizedBox(height: 0.0);
    }
  }
}
