import 'package:design/src/config/database/tables.dart';
import 'package:design/src/config/database/values.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class DatabaseInstance {
  Database? _database;

  DatabaseInstance() {
    database;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database =  await initDB();
      return _database!;
    }
  }

  Future<Database> initDB() async {
    final String path = join("", kDatabaseName);
    return openDatabase(
      path,
      version: dbVersion,
      password: dbPass,
      onCreate: (db, version) => _createTables(db, version: version),
      onUpgrade: (db, previous, current) => _upgrade(db, previous, current),
    );
  }

  Future<void> _createTables(Database db, {int version = dbVersion}) async {
    final Batch batch = db.batch();
    for (final schema in DBTables.schemas) {
      batch.execute(schema);
    }
    await batch.commit();
  }

  Future<void> _upgrade(
      Database db, int previousVersion, int currentVersion) async {
    final Batch batch = db.batch();
    for (int i = previousVersion + 1; i <= currentVersion; i++) {
      for (final migration in DBTables.migrations[i]!) {
        try {
          batch.execute(migration);
        } catch (error) {
          // ignore: avoid_print
          print(error);
        }
      }
    }
    await batch.commit();
  }
}
