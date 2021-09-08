import 'dart:convert';
import 'package:client/src/exercise/models/models.dart';
import 'package:client/src/mom/repository/secure_storage.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:dio/dio.dart'; //import the dio pachkage for data fetching'

//dio takes base url,options, and headers as a parameter.
//options take validate status as a parameter

class ExerciseDataProvider {
  static final String _baseUrl = "${Constants.emuBaseUrl}/exercise";
  static final dynamic _headers = {
    "accept": "/",
    // For latter use commented
    "Authorization": "Bearer ${Constants.token}",
    "Content-Type":
        "multipart/form-data" //application/json ...only for datas not for files
    //use multipart/form data if images or files are to passed to the db
  };

  Future<Exercise> create(dynamic exercise) async {
    final token = await SecureStorage().getToken();

    try {
      print("creating exercise started.....");
      String filename = exercise.image.path
          .split('/')
          .last; //gets the last file name from the given file path.....ie....C:home/user/image.jpg....gets the last name image.jpg
      FormData formData = FormData.fromMap({
        //to transfer image and data to backend
        "image": await MultipartFile.fromFile(exercise.image.path,
            filename: filename),
        "name": exercise.name,
        "type": exercise.type,
        "duration": exercise.duration,
        "description": exercise.description
      });
      final response = await Dio().post("$_baseUrl",
          data: formData,
          options: Options(
              headers: {
                "accept": "/",
                // For latter use commented
                "Authorization": "Bearer ${token}",
                "Content-Type":
                    "multipart/form-data" //application/json ...only for datas not for files
                //use multipart/form data if images or files are to passed to the db
              },
              validateStatus: (status) {
                return status! < 500;
              }));
      print(response);
      if (response.statusCode == 201) {
        return Exercise.fromJson(
            jsonDecode(jsonEncode(response.data["exercise"])));
      } else {
        throw Exception("Failed to create Exercise");
      }
    } catch (e) {
      print("Creating exercise failed");
      print(e);
      return Exercise(
          name: "name",
          type: "type",
          duration: "duration",
          image: "image",
          description: "description");
    }
  }

  Future<Exercise> fetchByOne(dynamic id) async {
    final token = await SecureStorage().getToken();

    print("fetching Exercise start ... $_baseUrl/$id");

    try {
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
      print(response.data["exercise"]);
      if (response.statusCode == 200) {
        return Exercise.fromJson(
            jsonDecode(jsonEncode(response.data["exercise"])));
      } else {
        throw Exception("fetching exercise by code failed");
      }
    } catch (e) {
      print("fetching exercise failed");
      print(e);
      return Exercise(
        name: "name",
        type: "type",
        duration: "duration",
        image: "image",
        description: "description",
      );
    }
  }

  Future<List<Exercise>> fetchAll() async {
    final token = await SecureStorage().getToken();

    print("fetching Exercise start ... $_baseUrl");
    try {
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
        final exercises =
            jsonDecode(jsonEncode(response.data["result"]["docs"]))
                as List<dynamic>;
        print(exercises.length);
        return exercises.map((a) => Exercise.fromJson(a)).toList();
      } else {
        throw Exception("fetching exercises by code failed");
      }
    } catch (e) {
      print("fetching exercise failed");
      print(e);
      List<Exercise> exercises = [
        Exercise(
            name: "name",
            type: "type",
            duration: "duration",
            image: "image",
            description: "description")
      ];
      return exercises;
    }
  }

  Future<Exercise> update(dynamic id, Exercise exercise) async {
    final token = await SecureStorage().getToken();

    print("updating Exercise start ...");
    print(exercise);
    final response = await Dio().patch('$_baseUrl/$id',
        data: {
          "name": exercise.name,
          "type": exercise.type,
          "duration": exercise.duration,
          "image": exercise.image,
          "description": exercise.description,
        },
        queryParameters: {"_method": "PUT"},
        options: Options(
          headers: {
            "accept": "/",
            // For latter use commented
            "Authorization": "Bearer ${token}",
            "Content-Type":
                "application/json" //application/json ...only for datas not for files
            //use multipart/form data if images or files are to passed to the db
          },
        ));
    print(response);
    if (response.statusCode == 200) {
      print(response.data);
      return Exercise.fromJson(
          jsonDecode(jsonEncode(response.data["exercise"])));
    } else {
      print("updating Exercise ended ...");
      throw Exception("Could not update exercise");
    }
  }

  Future<void> delete(dynamic id) async {
    final response = await Dio().delete('$_baseUrl/$id');
    if (response.statusCode != 200) {
      throw Exception("Field to delete the course");
    }
  }
}
