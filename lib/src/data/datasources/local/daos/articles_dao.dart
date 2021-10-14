import 'package:design/src/config/database/values.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ArticlesDao{
  Database? _database;

  ArticlesDao(){
    database;
  }

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    else{
      _database = await initDB();
      return _database!;
    }
  }

  Future<Database> initDB() async{
    final String path = join("", kDatabaseName);
    return openDatabase(path, password: dbPass);
  }
}
