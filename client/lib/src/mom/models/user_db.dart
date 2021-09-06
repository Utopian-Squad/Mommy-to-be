import 'package:client/src/cache/database_provider.dart';
import 'package:client/src/mom/models/user.dart';

class UserDB {
  final dbProvider = DatabaseProvider();

  Future<List<User>> getUsers() async {
    final db = await dbProvider.database;
    List<User> users = [];
    List<Map> queryList = await db!.rawQuery("select * from user");
    queryList.forEach(
      (user) {
        User u = User(
            id: user["id"],
            firstName: user["firstname"],
            lastName: user["lastname"],
            email: user["email"],
            phoneNumber: user["phonenumber"],
            image: user["image"],
            dateOfBirth: user["dateofbirth"]);
        u.address = user["address"];
        u.bloodType = user["bloodtype"];
        u.conceivingDate = user["conceivingdate"];
        u.cv = user["cv"];
        u.gender = user["gender"];
        u.password = user["password"];

        users.add(u);
      },
    );
    return users;
  }

  Future<User?> getUser(String id) async {
    final db = await dbProvider.database;
    List<Map> queryList =
        await db!.rawQuery("select * from user where id='$id'");
    if (queryList == null || queryList.length == 0) {
      return null;
    }
    var query = queryList[0];
    print(id);

    User user = User(
        id: query["id"],
        firstName: query["firstname"],
        lastName: query["lastname"],
        email: query["email"],
        phoneNumber: query["phonenumber"],
        image: query["image"],
        dateOfBirth: query["dateofbirth"]);
    user.address = query["address"];
    user.bloodType = query["bloodtype"];
    user.conceivingDate = query["conceivingdate"];
    user.cv = query["cv"];

    user.gender = query["gender"];
    user.password = query["password"];

    return user;
  }

  createUser(User user) async {
    final db = await dbProvider.database;
    db!.transaction((txn) async {
      await txn.rawDelete("delete from food where id='${user.id}'");
      print(user.id);
      String query =
          "insert into user(id,firstname,lastname,email,phonenumber,image,dateofbirth,address,bloodtype,conceivingdate,cv,gender,password)"
          " values("
          "'${user.id}',"
          "'${user.firstName}',"
          "'${user.lastName}',"
          "'${user.email}',"
          "'${user.phoneNumber}',"
          "'${user.image}',"
          "'${user.dateOfBirth}',"
          "'${user.address.toString()}',"
          "'${user.bloodType}',"
          "'${user.conceivingDate}',"
          "'${user.cv}',"
          "'${user.gender}',"
          "'${user.password}'"
          ")";
      print(query);
      await txn.rawInsert(query);
    });
  }

  deleteUser(String id) async {
    final db = await dbProvider.database;
    await db!.rawQuery("delete from user where id='$id'");
  }
}
