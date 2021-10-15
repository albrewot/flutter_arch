import 'dart:convert';

import 'package:design/src/config/database/values.dart';
import 'package:design/src/data/models/article_model.dart';
import 'package:design/src/domain/entities/article.dart';
import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

class ArticlesDao {
  Database? _database;

  ArticlesDao() {
    database;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDB();
      return _database!;
    }
  }

  List<Article> _parseArticles(List<Map<String, dynamic>> articles) {
    final List<Map<String, dynamic>> mapCopy =
        articles.map((e) => Map.of(e)).toList();
    return mapCopy.map((e) {
      e.update("source", (value) => json.decode(value as String));
      return ArticleModel.fromJson(e);
    }).toList();
  }

  Future<Database> initDB() async {
    final String path = join("", kDatabaseName);
    return openDatabase(path, password: dbPass);
  }

  Future<List<Article>> getArticles() async {
    try {
      Database db = await database;
      List<Map<String, dynamic>> result = await db.query(kArticlesTableName);
      List<Article> parsedArticles = _parseArticles(result);
      return parsedArticles;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> upsertArticle(Article article) async {
    try {
      final Database db = await database;
      int result = 0;
      Map<String, dynamic> convertedrticle = article.toJson();
      convertedrticle.update("source", (value) => json.encode(value));
      if (article.id != null) {
        result = await db.update(
          kArticlesTableName,
          convertedrticle,
          where: "id = ?",
          whereArgs: [article.id],
        );
      }
      if (result == 0) {
        result = await db.insert(
          kArticlesTableName,
          convertedrticle,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> upsertArticles(List<Article> articles) async {
    try {
      for (final article in articles) {
        await upsertArticle(article);
      }
      return;
    } catch (error) {
      rethrow;
    }
  }

  Future deleteArticle(int id) async {
    try {
      final Database db = await database;
      await db.delete(
        kArticlesTableName,
        where: "id = ?",
        whereArgs: [id],
      );
      return;
    } catch (error) {
      rethrow;
    }
  }
}
