import 'package:client/src/exercise/blocs/blocs.dart';
import 'package:client/src/exercise/blocs/exercise_bloc.dart';
import 'package:client/src/exercise/blocs/exercise_state.dart';
import 'package:client/src/exercise/models/exercise_argument.dart';
import 'package:client/src/exercise/repository/exercise_repository.dart';
import 'package:client/src/exercise/screens/nurse_exercise_form.dart';
import 'package:client/src/exercise/widgets/exercise_detail.dart';
import 'package:client/src/exercise/widgets/image_slider_exercise.dart';
import 'package:client/src/mom/bloc/bloc.dart';
import 'package:client/src/mom/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'exercise_card.dart';

class ExerciseHomeScreen extends StatelessWidget {
  static const String routeName = "/exercise";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExerciseBloc>(context).add(ExerciseLoad());
    return SafeArea(
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return (state is AuthenticationAuthenticated)
              ? Scaffold(
                  appBar: (state.user?.role["roleName"] != "mom")
                      ? AppBar(
                          title: Text("Exercises"),
                          backgroundColor: Colors.pink[400],
                        )
                      : null,
                  drawer: (state.user?.role["roleName"] != "mom")
                      ? NavigationDrawerWidget()
                      : null,
                  body: BlocBuilder<ExerciseBloc, ExerciseState>(
                    builder: (context, state) {
                      if (state is ExerciseOperationSuccess) {
                        final exercises = state.exercises;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Kegel Exercises",
                                style: GoogleFonts.pacifico(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 30,
                                  color: Colors.purple,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Container(
                                child: ImageSlideExercise(),
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
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
                                                exercise:
                                                    exercises.elementAt(index)),
                                            onTap: () => Navigator.of(context)
                                                .pushNamed(
                                                    ExerciseDetail.routeName,
                                                    arguments: exercises
                                                        .elementAt(index)),
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
                  floatingActionButton: (state
                          .user?.role["privileges"][0]["permissions"]
                          .contains("create"))
                      ? FloatingActionButton(
                          backgroundColor: Colors.pinkAccent,
                          child: const Icon(Icons.add),
                          onPressed: () => Navigator.of(context).pushNamed(
                            NurseExerciseForm.routeName,
                            arguments: ExerciseArgument(edit: false),
                          ),
                        )
                      : null,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
          ;
        },
      ),
    );
  }
}
