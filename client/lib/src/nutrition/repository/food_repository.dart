import 'package:client/src/nutrition/data_providers/food_data_provider.dart';
import 'package:client/src/nutrition/models/food_db.dart';
import 'package:client/src/nutrition/models/food_model.dart';

class FoodRepository {
  final FoodDataProvider dataProvider;
  final dbProvider = FoodDB();

  FoodRepository(this.dataProvider);

  Future<Food?> create(Food food) async {
    return this.dataProvider.create(food);
  }

  Future<Food> update(dynamic id, Food food) async {
    var foods = await this.dataProvider.update(id, food);
    try {
      print("inserting into database food");
      await dbProvider.createFood(food);
    } catch (e) {
      print("unable to write database");
    }
    return foods;
  }

  Future<List<Food>> fetchAll() async {
    print("from repo");
    try {
      print("fetching from network");
      var foods = await this.dataProvider.fetchAll();
      try {
        if (foods.length != 0) {
          print("deleting food records");
          print("inserting into database food");
          foods.forEach((food) async {
            await dbProvider.createFood(food);
          });
          return foods;
        } else {
          return [];
        }
      } catch (e) {
        print("database save food error");
        return [];
      }
    } catch (e) {
      print("fetching from database");
      var foods = await dbProvider.getFoods();
      print(
          '0000000000000000000000000000000000000000000000000000000000000000000000000000000');
      print(foods);
      print(
          '00000000000000000000000000000000000000000000000000000000000000000000000000');
      return foods;
    }
  }

  Future<Food?> fetchByOnel(dynamic id) async {
    try {
      print("fetching from network");
      Food food = await this.dataProvider.fetchByOne(id);
      try {
        print("inserting into database food");
        // await dbProvider.deleteAppointment(id);
        await dbProvider.createFood(food);
      } catch (e) {
        print("database save food error");
      }
    } catch (e) {
      print("fetching from database");
      Food? food = await dbProvider.getFood(id);
      return food;
    }
  }

  Future<void> delete(dynamic id) async {
    try {
      await dbProvider.deleteFood(id);
    } catch (e) {}
    await this.dataProvider.delete(id);
  }
}
