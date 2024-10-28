mport 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bullet_journal.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE JournalPage(id INTEGER PRIMARY KEY, title TEXT, createdDate TEXT)',
    );
  }

  Future<int> insertJournalPage(JournalPage page) async {
    final db = await database;
    return await db.insert('JournalPage', page.toMap());
  }

  Future<List<JournalPage>> getJournalPages() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('JournalPage');
    return List.generate(maps.length, (i) {
      return JournalPage(
        id: maps[i]['id'],
        title: maps[i]['title'],
        createdDate: DateTime.parse(maps[i]['createdDate']),
      );
    });
  }
}

