import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DatabaseHelper {
  static Future<sql.Database> getDatabase() async {
    final databasePath = await sql.getDatabasesPath();

    return sql.openDatabase(
        path.join(databasePath, 'places.db'), onCreate: (database, version) {
      return database.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, location_latitude REAL, location_langitude REAL, address TEXT)',
      );
    }, version: 1);
  }
  static Future<void> insert(String table, Map<String, Object> data) async {
    final database = await DatabaseHelper.getDatabase();

    database.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> fetchData(String table) async {
    final database = await DatabaseHelper.getDatabase();
    return database.query(table);
  }
}
