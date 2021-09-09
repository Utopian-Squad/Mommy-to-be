import 'package:client/src/mom/models/user.dart';
import 'package:client/src/mom/repository/secure_storage.dart';
import 'package:client/src/utilities/constants.dart';
import 'package:dio/dio.dart';

class UserListProvider {
  UserListProvider();

  Future<List<User>> getUserList() async {
    try {
      print('Fetching Start User list data provider...');
      var token = await SecureStorage().getToken();
      var response = await Dio().get('${Constants.baseUrl}/user',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }, validateStatus: (status) => status! < 500));

      if (response.statusCode == 200) {
        print('-------------------> Done');

        final users = response.data["result"]["docs"] as List;

        return users.map((user) => User.fromJson(user)).toList();
      } else {
        throw Exception('Fetching Failed User list data provider...');
      }
    } catch (e) {
      throw Exception('Fetching Failed User list data provider...');
    }
  }

  Future<void> updateUser(String id, String roleId) async {
    try {
      print(await SecureStorage().getToken());
      print('Fetching Start User update data provider...');

      var token = await SecureStorage().getToken();

      var response = await Dio().patch('${Constants.baseUrl}/user/${id}',
          data: {"roles": roleId},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }, validateStatus: (status) => status! < 500));

      print(response.data);

      if (response.statusCode == 200) {
        print('-------------------> Done');
      } else {
        throw Exception('Fetching Failed User list data provider...');
      }
    } catch (e) {
      throw Exception('Fetching Failed User list data provider...');
    }
  }

}
