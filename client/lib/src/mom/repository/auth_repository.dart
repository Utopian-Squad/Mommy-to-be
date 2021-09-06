import 'package:client/src/mom/data_providers/auth_data_provider.dart';
import 'package:client/src/mom/models/user.dart';

class AuthRepository {
  final AuthProvider authProvider;

  AuthRepository({required this.authProvider});
  Future<dynamic> signup(User user) async {
    print("------------> Repository SignUp");
    return await authProvider.signup(user);
  }

  Future<dynamic> login(String phone, String password) async {
    print('------------> Repository Login');
    return await authProvider.login(phone, password);
  }

  Future<dynamic> updateProfile(String firstName, String lastName, String email,
      String phoneNumber) async {
    print('------------> Repository Update');
    return await authProvider.updateProfile(
        firstName, lastName, phoneNumber, email);
  }

  Future<void> deleteUser(String id) async {
    return await authProvider.deleteUser(id);
  }
}
