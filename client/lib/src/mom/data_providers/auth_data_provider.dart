import 'package:client/src/mom/repository/secure_storage.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:dio/dio.dart';
import 'package:client/src/mom/models/user.dart';

class AuthProvider {
  AuthProvider();

  Future<void> deleteUser(String id) async {
    // final id = await SecureStorage().getId();
    final token = await SecureStorage().getToken();
    final response = await Dio().delete('${Constants.emuBaseUrl}/user/$id',
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            "Authorization": "Bearer ${token}",
          },
        ));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete role...');
    }
  }

  Future<dynamic> signup(User user) async {
    try {
      print("Fetching Start SignUp Data Provider...");
      print(user.cv);
      String filename = user.image.path.split('/').last;
      print("------");
      print(user.image);
      FormData formData = FormData.fromMap({
        "files": [
          user.image != ''
              ? await MultipartFile.fromFile(
                  user.image.path,
                  filename: filename,
                )
              : "",
          user.cv != ''
              ? await MultipartFile.fromFile(
                  user.cv.path,
                  filename: user.cv.path.split('/').last,
                )
              : "",
        ],
        "firstName": user.firstName,
        "lastName": user.lastName,
        "dateOfBirth": user.dateOfBirth,
        "email": user.email,
        "password": user.password,
        "address": user.address,
        "dateOfBirth": user.dateOfBirth,
        "bloodType": user.bloodType,
        "conceivingDate": user.conceivingDate,
        "gender": user.gender,
        "phoneNumber": user.phoneNumber,
      });

      var response = await Dio().post(
        '${Constants.emuBaseUrl}/user/signup',
        data: formData,
        options: Options(
          validateStatus: (status) => status! < 500,
          headers: {
            "accept": "/",
            // For latter use commented
            // "Authorization" : "Bearer nsnadidasnkdw"
            "Content-Type": "multipart/form-data"
          },
        ),
      );
      print(response);
      if (response.statusCode == 201) {
        print("-------------------> Done");
        var user = User.fromJson(response.data["user"]);
        Map<String, dynamic> result = {
          "token": response.data["token"],
          "user": user
        };
        return result;
      }
    } catch (e) {
      print("Fetching Failed SignUp Data Provider...");
      print(e);
      return null;
    }
  }

  Future<dynamic> login(String phone, String password) async {
    try {
      print("Fetching Start Login Data Provider...");

      var response = await Dio().post('${Constants.baseUrl}/user/login',
          data: {'phoneNumber': phone, 'password': password},
          options: Options(validateStatus: (status) => status! < 500));
      print(response.data);
      // print(await SecureStorage().hasToken());
      if (response.statusCode == 201) {
        var user = User.fromJson((response.data["user"]));

        Map<String, dynamic> result = {
          "token": response.data["token"],
          "user": user
        };

        return result;
      }
    } catch (e) {
      print(e);
      print("Fetching Failed Login Data Provider...");
      return null;
    }
  }

  Future<void> updateProfile(String firstName, String lastName,
      String phoneNumber, String email) async {
    try {
      print('Fetching Start Get User Data Provider...');
      final id = await SecureStorage().getId();
      final token = await SecureStorage().getToken();
      final response = await Dio().patch('${Constants.baseUrl}/user/${id}',
          data: {
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber
          },
          options: Options(headers: <String, String>{
            "accept": "/",
            // For latter use commented
            "Authorization": "Bearer ${token}",
            'Content-Type': 'application/json; charset=UTF-8'
          }));
    } catch (e) {
      print(e);
    }
  }
}
