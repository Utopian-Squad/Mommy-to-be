import 'dart:convert';
import 'package:client/src/suggestion/models/suggestion_model.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:dio/dio.dart'; //import the dio pachkage for data fetching'

//dio takes base url,options, and headers as a parameter.
//options take validate status as a parameter

class SuggestionDataProvider {
  static final String _baseUrl = "${Constants.emuBaseUrl}/suggestion";
  static final dynamic _headers = {
    "accept": "/",
    // For latter use commented
    "Authorization": "Bearer ${Constants.token}",
    "Content-Type":
        "multipart/form-data" //application/json ...only for datas not for files
    //use multipart/form data if images or files are to passed to the db
  };

  Future<List<Suggestion>> fetchAll(int countdown) async {
    print("fetching Suggestion start ... $_baseUrl");
    try {
      final response = await Dio().get(
        '$_baseUrl',
        queryParameters: {"countdown": countdown},
        options: Options(
          validateStatus: (status) {
            return status! < 500;
          },
          headers: {
            "accept": "/",
            // For latter use commented
            "Authorization":
                //sample current logged in user token
                "Bearer ${Constants.token}",
            //receives only json data....no file to be passed.....it returns images only in string form.
            "Content-Type": "application/json"
          },
        ),
      );
      print(response.data["result"]["docs"]);
      if (response.statusCode == 200) {
        final suggestions =
            jsonDecode(jsonEncode(response.data["result"]["docs"]))
                as List<dynamic>;
        print(suggestions.length);
        return suggestions.map((a) => Suggestion.fromJson(a)).toList();
      } else {
        throw Exception("fetching suggestions by code failed");
      }
    } catch (e) {
      print("fetching suggestion failed");
      print(e);
      List<Suggestion> suggestions = [
        Suggestion(
            countDown: "countDown",
            foodId: "foodId",
            exerciseId: "exerciseId",
            symptoms: "symptoms",
            timeline: "timeline",
            description: "description")
      ];
      return suggestions;
    }
  }
}
