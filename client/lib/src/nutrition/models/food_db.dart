import 'package:client/src/cache/database_provider.dart';
import 'package:client/src/nutrition/models/food_model.dart';

class FoodDB {
  final dbProvider = DatabaseProvider();

  Future<List<Food>> getFoods() async {
    final db = await dbProvider.database;
    List<Food> foods = [];
    List<Map> queryList = await db!.rawQuery("select * from food");
    queryList.forEach(
      (food) {
        // Food
        Food f = Food(
            id: food["id"],
            description: food["description"],
            display: food["display"],
            image: food["image"],
            name: food["name"],
            type: food["type"]);
        foods.add(f);
      },
    );
    return foods;
  }

  Future<Food> getFood(String id) async {
    final db = await dbProvider.database;
    List<Map> queryList =
        await db!.rawQuery("select * from food where id='$id'");
    var query = queryList[0];

    Food food = Food(
        id: query["id"],
        description: query["description"],
        display: query["display"],
        image: query["image"],
        name: query["name"],
        type: query["type"]);

    return food;
  }

  createFood(Food food) async {
    final db = await dbProvider.database;
    db!.transaction((txn) async {
      await txn.rawDelete("delete from food where id='${food.id}'");
      String query =
          "insert into food(id,description,display,image,name,type) values('${food.id}','${food.description}','${food.display}','${food.image}','${food.name}','${food.type}')";
      print("========================food=======================");
      print(query);
      await txn.rawInsert(query);
    });
  }

  deleteFood(String id) async {
    final db = await dbProvider.database;
    await db!.rawDelete("delete from food where id='$id'");
  }
}
