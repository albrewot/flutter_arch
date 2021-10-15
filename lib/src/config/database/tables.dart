import 'package:design/src/config/database/values.dart';

// ignore: avoid_classes_with_only_static_members
class DBTables {
  static List<String> schemas = [
    """
    CREATE TABLE IF NOT EXISTS $kArticlesTableName(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      source TEXT,
      author VARCHAR(180),
      title TEXT,
      description TEXT,
      url TEXT,
      urlToImage TEXT,
      publishedAt VARCHAR(255),
      content TEXT
    )"""
  ];

  static Map<int, List<String>> migrations = {
    1: [
      """
      CREATE TABLE IF NOT EXISTS $kArticlesTableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        source TEXT,
        author VARCHAR(180),
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt VARCHAR(255),
        content TEXT
      )"""
    ]
  };
}
