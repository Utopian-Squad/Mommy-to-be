
import 'package:client/src/mom/models/user.dart';
import 'package:client/src/user_list/data_provider/user_list_provider.dart';

class UserListRepository {
  final UserListProvider userListProvider;

  UserListRepository({required this.userListProvider});

  Future<List<User>> getUserList() async {
    print('--------------------> Repository UserList');
    return await userListProvider.getUserList();
  }

  Future<void> updateUser(String id, String roleId) async {
    print('--------------------> Repository UpdateUser');
    return await userListProvider.updateUser(id, roleId);
  }
}
