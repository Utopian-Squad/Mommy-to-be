import 'package:client/src/exercise/blocs/blocs.dart';
import 'package:client/src/exercise/blocs/exercise_bloc.dart';
import 'package:client/src/exercise/blocs/exercise_state.dart';
import 'package:client/src/exercise/repository/exercise_repository.dart';
import 'package:client/src/exercise/repository/exercise_repository.dart';
import 'package:client/src/exercise/widgets/exercise_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'exercise_card.dart';

class ExerciseHomeScreen extends StatelessWidget {
  static const String routeName = "/exercise";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ExerciseBloc, ExerciseState>(
          builder: (context, state) {
            if (state is ExerciseOperationSuccess) {
              final exercises = state.exercises;
              return Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        margin: EdgeInsets.only(top: 40),
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(80))),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.recommend_outlined,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          "Recommended exercises",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      child: exercises.length == 1 &&
                              exercises.elementAt(0).type == "type"
                          ? Center(child: Text("No Exercises "))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: exercises.length,
                              itemBuilder: (_, index) {
                                return GestureDetector(
                                  child: ExerciseCard(
                                      exercise: exercises.elementAt(index)),
                                  onTap: () => Navigator.of(context).pushNamed(
                                      ExerciseDetail.routeName,
                                      arguments: exercises.elementAt(index)),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              );
            }
            if (state is ExerciseOperationFailure) {
              return Text('Could not do Exercise operation');
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
