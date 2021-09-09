import 'package:client/src/exercise/models/exercise_argument.dart';
import 'package:client/src/exercise/models/exercise_model.dart';
import 'package:client/src/exercise/screens/nurse_exercise_form.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ExerciseDetail extends StatelessWidget {
  static const String routeName = "/exerciseDetail";
  final Exercise exercise;
  ExerciseDetail({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    NurseExerciseForm.routeName,
                    arguments:
                        ExerciseArgument(edit: true, exercise: this.exercise),
                  );
                },
                icon: Icon(Icons.edit))
          ],
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.purple[50]),
          child: Column(
            children: [
              Expanded(
                  child: Image.network(
                      "${Constants.imageBaseUrl}images/exercise/${exercise.image}")),
              Text(
                "${exercise.name}",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(80),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("${exercise.description}"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
