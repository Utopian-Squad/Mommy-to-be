import 'dart:io';

import 'package:client/src/exercise/data_providers/exercise_data_provider.dart';
import 'package:client/src/exercise/models/exercise_db.dart';
import 'package:client/src/exercise/models/exercise_model.dart';

class ExerciseRepository {
  final ExerciseDataProvider dataProvider;
  final dbProvider = ExerciseDB();
  ExerciseRepository(this.dataProvider);

  Future<Exercise?> create(Exercise exercise) async {
    print("from repo");
    return this.dataProvider.create(exercise);
  }

  Future<Exercise> update(dynamic id, Exercise exercise) async {
    var appt = await this.dataProvider.update(id, exercise);
    try {
      print("inserting into database exercise");
      await dbProvider.createExercise(exercise);
    } catch (e) {
      print("unable to write database");
    }
    return appt;
  }

  Future<List<Exercise>> fetchAll() async {
    print("from repo");
    try {
      print("fetching from network");
      var exercises = await this.dataProvider.fetchAll();
      try {
        if (exercises.length != 0) {
          print("deleting exercise records");
          print("inserting into database exercise");
          exercises.forEach((exercise) async {
            await dbProvider.createExercise(exercise);
          });
          return exercises;
        } else {
          return [];
        }
      } catch (e) {
        print("database save exercises error");
        return [];
      }
    } catch (e) {
      print("fetching from database");
      var exercises = await dbProvider.getExercises();
      print(
          '0000000000000000000000000000000000000000000000000000000000000000000000000000000');
      print(exercises);
      print(
          '00000000000000000000000000000000000000000000000000000000000000000000000000');
      return exercises;
    }
  }

  Future<Exercise?> fetchByOnel(dynamic id) async {
    try {
      print("Fetching from netword");
      Exercise exercise = await this.dataProvider.fetchByOne(id);
      try {
        print('inserting exercise to db');
        await dbProvider.createExercise(exercise);
      } catch (e) {
        print("database save exercise failed");
      }
    } catch (e) {
      print('fetching exercise from db');
      Exercise? exercise = await dbProvider.getExercise(id);
      return exercise;
    }
  }

  Future<void> delete(dynamic id) async {
    try {
      await dbProvider.deleteExercise(id);
    } catch (e) {}
    await this.dataProvider.delete(id);
  }
}
