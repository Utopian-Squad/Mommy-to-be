import 'package:client/src/exercise/blocs/exercise_bloc.dart';
import 'package:client/src/exercise/blocs/exercise_state.dart';
import 'package:client/src/exercise/models/models.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../fitness_app_theme.dart';

class ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  ExerciseCard({required this.exercise});

  final Color startColor = Colors.pink[300]!;

  final Color endColor = Colors.purple[400]!;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 250,
      child: SizedBox(
        width: 13,
        child: Stack(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.pink.withOpacity(0.6),
                        offset: const Offset(1.1, 4.0),
                        blurRadius: 8.0),
                  ],
                  gradient: LinearGradient(
                    colors: [
                      startColor,
                      Colors.purple[400]!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(54.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 54, left: 16, right: 16, bottom: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            "Type : ",
                            style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 0.2,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                          Text(
                            "${exercise.type}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 0.2,
                              color: FitnessAppTheme.white,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${exercise.duration}",
                                style: TextStyle(
                                  fontFamily: FitnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: 0.2,
                                  color: Color(0xFFFFFFFF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      5 != 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "${exercise.name}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    // fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: 0.2,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFAFAFA),
                                shape: BoxShape.circle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xFF213333).withOpacity(0.4),
                                      offset: Offset(8.0, 8.0),
                                      blurRadius: 8.0),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: Color(0xFFFAFAFA),
                                  size: 24,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: SizedBox(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(
                                "${Constants.imageBaseUrl}images/exercise/${exercise.image}")
                            .image,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
