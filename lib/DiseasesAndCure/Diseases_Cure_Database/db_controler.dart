import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'disease_model.dart';

class DBController {
  static final DBController _instance = DBController._internal();
  factory DBController() => _instance;
  DBController._internal();

  static Database? _database;

  Future<Database> get database async {
    return _database ??= await _initDB();
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'disease_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE diseases(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            disease_name TEXT,
            cure TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertDisease(DiseaseModel disease) async {
    final db = await database;
    return await db.insert('diseases', disease.toMap());
  }

  Future<List<DiseaseModel>> getAllDiseases() async {
    final db = await database;
    final result = await db.query('diseases');
    return result.map((e) => DiseaseModel.fromMap(e)).toList();
  }

  Future<int> deleteDisease(int id) async {
    final db = await database;
    return await db.delete('diseases', where: 'id = ?', whereArgs: [id]);
  }
}
