import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperNew {
  static final DatabaseHelperNew _instance = DatabaseHelperNew._init();
  static Database? _database;

  DatabaseHelperNew._init();

  static DatabaseHelperNew get instance => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('practice.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const sql = '''
      CREATE TABLE records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        loftName TEXT NOT NULL,
        flyingDate TEXT NOT NULL,
        flyingTime TEXT NOT NULL,
        totalBirds INTEGER NOT NULL,
        birdsNames TEXT NOT NULL,
        babybirdname TEXT NOT NULL
      )
    ''';
    await db.execute(sql);
  }

  Future<int> insertRecord(Map<String, dynamic> record) async {
    final db = await instance.database;
    return await db.insert('records', record);
  }

  Future<List<Map<String, dynamic>>> fetchRecords() async {
    final db = await instance.database;
    return await db.query(
      'records',
      columns: [
        'id',
        'loftName',
        'flyingDate',
        'flyingTime',
        'totalBirds',
        'birdsNames',
        'babybirdname'
      ],
      orderBy: 'id DESC',
    );
  }

  Future<void> updateRecord(Map<String, dynamic> record) async {
    final db = await database;
    await db.update(
      'records',
      record,
      where: 'id = ?',
      whereArgs: [record['id']],
    );
  }

  Future<int> deleteRecords(int id) async {
    final db = await instance.database;
    return await db.delete(
      'records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

