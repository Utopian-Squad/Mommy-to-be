import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static final DatabaseProvider dbProvider = DatabaseProvider();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'Redu.db');

    var database = await openDatabase(path,
        version: 1, onCreate: initDB, onUpgrade: onUpgrade);
    return database;
  }

  void onUpgrade(Database database, int oldVersion, int newVersion) {
    if (newVersion > oldVersion) {}
  }

  void initDB(Database database, int version) async {
    await database.execute("CREATE TABLE user("
        "dbId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "id varchar,"
        "firstname varchar,"
        "lastname varchar,"
        "phonenumber varchar,"
        "password varchar,"
        "email varchar,"
        "image varchar,"
        "address varchar,"
        "gender varchar,"
        "dateofbirth varchar,"
        "bloodtype varchar,"
        "cv varchar,"
        "conceivingdate varchar,"
        "role varchar )");

    await database.execute("CREATE TABLE food("
        "dbId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "id varchar,"
        "name varchar,"
        "type varchar,"
        "display varchar,"
        "description varchar,"
        "image varchar)");

    await database.execute("CREATE TABLE exercise("
        "dbId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "id varchar,"
        "name varchar,"
        "type varchar,"
        "duration varchar,"
        "image varchar,"
        "description varchar)");
    print("table created");
    await database.execute("CREATE TABLE suggestion("
        "dbId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "id varchar,"
        "countdown varchar,"
        "foodid varchar,"
        "exerciseid varchar,"
        "symptoms varchar,"
        "timeline varchar,"
        "description varchar)");
  }
}
