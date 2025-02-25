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
      // Agar aapko upgrade functionality chahiye to onUpgrade callback bhi add kar sakte hain.
    );
  }

  Future _createDB(Database db, int version) async {
    // Modified SQL with additional columns:
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

  // Agar aap upgrade karna chahte hain, to niche ka code uncomment aur use kar sakte hain.
  // Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 2) {
  //     await db.execute('ALTER TABLE records ADD COLUMN birdsNames TEXT');
  //     await db.execute('ALTER TABLE records ADD COLUMN babybirdname TEXT');
  //   }
  //   if (oldVersion < 3) {
  //     await db.execute('ALTER TABLE records ADD COLUMN totalBirds INTEGER NOT NULL DEFAULT 0');
  //   }
  // }

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
      orderBy: 'id DESC', // Records descending order (latest first)
    );
  }

  Future<int> deleteRecords(int id) async {
    final db = await instance.database;
    int deletedRows = await db.delete(
      'records',
      where: 'id = ?',
      whereArgs: [id],
    );
    print("Deleted rows: $deletedRows");
    return deletedRows;
  }
}
