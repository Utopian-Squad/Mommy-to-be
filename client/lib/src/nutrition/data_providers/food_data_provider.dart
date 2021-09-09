import 'dart:convert';
import 'package:client/src/mom/repository/secure_storage.dart';
import 'package:client/src/nutrition/models/food_model.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:dio/dio.dart';

//dio takes base url,options, and headers as a parameter.
//options take validate status as a parameter

class FoodDataProvider {
  static final String _baseUrl = "${Constants.emuBaseUrl}/food";
  static final dynamic _headers = {
    "accept": "/",
    "Authorization": "Bearer ${Constants.token}",
    "Content-Type":
        "multipart/form-data" //application/json ...only for datas not for files
    //use multipart/form data if images or files are to passed to the db
  };

  Future<Food> create(dynamic food) async {
    final token = await SecureStorage().getToken();

    print("creating food started.....");
    String filename = food.image.path
        .split('/')
        .last; //gets the last file name from the given file path.....ie....C:home/user/image.jpg....gets the last name image.jpg
    FormData formData = FormData.fromMap({
      //to transfer image and data to backend
      "image":
          await MultipartFile.fromFile(food.image.path, filename: filename),
      "name": food.name,
      "type": food.type,
      "display": food.display,
      "description": food.description
    });
    final response = await Dio().post("$_baseUrl",
        data: formData,
        options: Options(
            headers: {
              "accept": "/",
              "Authorization": "Bearer ${Constants.token}",
              "Content-Type":
                  "multipart/form-data" //application/json ...only for datas not for files
              //use multipart/form data if images or files are to passed to the db
            },
            validateStatus: (status) {
              return status! < 500;
            }));
    print(response);
    if (response.statusCode == 201) {
      return Food.fromJson(jsonDecode(jsonEncode(response.data["food"])));
    } else {
      throw Exception("Failed to create Food");
    }
  }

  Future<Food> fetchByOne(dynamic id) async {
    final token = await SecureStorage().getToken();

    print("fetching Food start ... $_baseUrl/$id");
    final response = await Dio().get(
      '$_baseUrl/$id',
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "accept": "/",
          // For latter use commented
          "Authorization": "Bearer ${token}",
          "Content-Type": "application/json"
        },
      ),
    );
    print(response.data["food"]);
    if (response.statusCode == 200) {
      return Food.fromJson(jsonDecode(jsonEncode(response.data["food"])));
    } else {
      throw Exception("fetching food by code failed");
    }
  }

  Future<List<Food>> fetchAll() async {
    final token = await SecureStorage().getToken();

    print("fetching Food start ... $_baseUrl");
    final response = await Dio().get(
      '$_baseUrl',
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "accept": "/",
          // For latter use commented
          "Authorization":
              //sample current logged in user token
              "Bearer ${token}",
          //receives only json data....no file to be passed.....it returns images only in string form.
          "Content-Type": "application/json"
        },
      ),
    );
    print(response.data["result"]["docs"]);
    if (response.statusCode == 200) {
      final exercises = jsonDecode(jsonEncode(response.data["result"]["docs"]))
          as List<dynamic>;
      print(exercises.length);
      return exercises.map((a) => Food.fromJson(a)).toList();
    } else {
      throw Exception("fetching foods by code failed");
    }
  }

  Future<Food> update(dynamic id, Food food) async {
    final token = await SecureStorage().getToken();

    print("updating Food start ...");
    final response = await Dio().patch('$_baseUrl/$id',
        data: {
          "name": food.name,
          "type": food.type,
          "display": food.display,
          "image": food.image,
          "description": food.description,
        },
        options: Options(headers: {
          "accept": "/",
          // For latter use commented
          "Authorization": "Bearer ${token}",
          "Content-Type":
              "application/json" //application/json ...only for datas not for files
          //use multipart/form data if images or files are to passed to the db
        }));
    if (response.statusCode == 200) {
      print(response.data);
      return Food.fromJson(jsonDecode(response.data));
    } else {
      print("updating Food ended ...");
      throw Exception("Could not update food");
    }
  }

  Future<void> delete(dynamic id) async {
    final token = await SecureStorage().getToken();

    final response = await Dio().delete('$_baseUrl/$id',
        options: Options(headers: {
          "accept": "/",
          // For latter use commented
          "Authorization": "Bearer ${token}",
        }));
    if (response.statusCode != 200) {
      throw Exception("Field to delete the food");
    }
  }
}
