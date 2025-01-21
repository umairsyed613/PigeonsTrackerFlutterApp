import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperNew {
  // Singleton pattern for DatabaseHelper
  static final DatabaseHelperNew _instance = DatabaseHelperNew._init();
  static Database? _database;

  // Private constructor
  DatabaseHelperNew._init();

  // Getter to access the singleton instance
  static DatabaseHelperNew get instance => _instance;

  // Method to initialize the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('practice.db');
    return _database!;
  }

  // Initialize the database file
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create the database table
  Future _createDB(Database db, int version) async {
    const sql = '''
      CREATE TABLE records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        loftName TEXT NOT NULL,
        flyingDate TEXT NOT NULL,
        flyingTime TEXT NOT NULL
      )
    ''';
    await db.execute(sql);
  }

  // Insert a new record into the database
  Future<int> insertRecord(Map<String, dynamic> record) async {
    final db = await instance.database;
    return await db.insert('records', record);
  }

  // Fetch all records from the database
  Future<List<Map<String, dynamic>>> fetchRecords() async {
    final db = await instance.database;
    return await db.query('records');
  }
}
