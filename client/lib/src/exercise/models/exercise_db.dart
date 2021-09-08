import 'package:client/src/cache/database_provider.dart';
import 'package:client/src/exercise/models/models.dart';

class ExerciseDB {
  final dbProvider = DatabaseProvider();

  Future<List<Exercise>> getExercises() async {
    final db = await dbProvider.database;
    List<Exercise> exercises = [];
    List<Map> queryList = await db!.rawQuery("select * from exercise");
    queryList.forEach(
      (exercise) {
        print(exercise["id"]);
        Exercise e = Exercise(
            description: exercise["description"],
            duration: exercise["duration"],
            image: exercise["image"],
            name: exercise["name"],
            type: exercise["type"],
            id: exercise["id"]);
        exercises.add(e);
      },
    );
    return exercises;
  }

  Future<Exercise?> getExercise(String id) async {
    final db = await dbProvider.database;
    List<Map> queryList =
        await db!.rawQuery("select * from exercise where id='$id'");
    if (queryList == null || queryList.length == 0) {
      return null;
    }
    var query = queryList[0];

    Exercise exercise = Exercise(
        description: query["description"],
        duration: query["duration"],
        image: query["image"],
        name: query["name"],
        type: query["type"],
        id: query["id"]);
    return exercise;
  }

  createExercise(Exercise exercise) async {
    final db = await dbProvider.database;
    db!.transaction((txn) async {
      await txn.rawDelete("delete from exercise where id='${exercise.id}'");
      String query =
          "insert into exercise(id,name,type,duration,image,description) values('${exercise.id}','${exercise.name}','${exercise.type}','${exercise.duration}','${exercise.image}','${exercise.description}')";
      print("========================exercise=======================");
      print(exercise.id);
      await txn.rawInsert(query);
    });
  }

  deleteExercise(String id) async {
    final db = await dbProvider.database;
    await db!.rawQuery("delete from exercise where id='$id'");
  }
}
