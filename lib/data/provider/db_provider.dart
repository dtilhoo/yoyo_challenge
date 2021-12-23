import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/article_feed.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  static const String _tableName = 'Article';

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'article_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE $_tableName('
          '_id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'title TEXT,'
          'description TEXT,'
          'link TEXT,'
          'imageUrl TEXT'
          ')');
    });
  }

  createArticle(Item newArticle) async {
    final db = await database;
    final res = await db.insert(_tableName, newArticle.toJson());

    return res;
  }

  Future<int> deleteAllArticles() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM $_tableName');

    return res;
  }

  Future<List<Item>> getAllArticles() async {
    final db = await database;
    final res = await db.query(_tableName);

    List<Item> list =
        res.isNotEmpty ? res.map((c) => Item.fromSqlJson(c)).toList() : [];

    return list;
  }
}
