import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SQLDatabase {
  static Database? _db;

  Future<Database?> get db async {
    // ignore: unnecessary_null_comparison
    if (_db == null) {
      _db = await createDatabase();
      return _db;
    } else {
      return _db;
    }
  }

// create Database
// this method is execute  to create database in first time
  createDatabase() async {
    // Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, "favorite.db");
    Database db = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);

    return db;
  }

  _onCreate(Database db, int version) async {
    // When creating the db, create the table
    //            id INTEGER PRIMARY KEY AUTOINCREMENT,
    await db.execute('''
          CREATE TABLE "MyFavorite"(
            id TEXT PRIMARY KEY NOT NULL,
            title TEXT,
            price TEXT, 
            imageUrl TEXT
            )
            ''');
    await db.execute('''
          CREATE TABLE "Invoice"(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            phone TEXT, 
            email TEXT,
            zibCode TEXT,
            city TEXT,
            local TEXT,
            country TEXT
            )
            ''');
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  getData(String sql) async {
    Database? myDB = await db;

    List<Map> response = await myDB!.rawQuery(sql);

    return response;
  }

  Future<int> insertData(String sql) async {
    Database? myDB = await db;
    try {
      int response = await myDB!.rawInsert(sql);
      return response;
    } catch (error) {
      return 1;
    }
  }

  updateData(String sql) async {
    Database? myDB = await db;

    int response = await myDB!.rawUpdate(sql);

    return response;
  }

  Future<int> deleteData(String sql) async {
    Database? myDB = await db;

    int response = await myDB!.rawDelete(sql);

    return response;
  }
}
