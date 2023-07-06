import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'tables/db_tables.dart';

//Manage sqflite local db
class DBManager {
  static final DBManager instance = DBManager._init();
  DBManager._init();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = join(await getDatabasesPath(), filePath);
    // final path = join(dbPath, filePath);
    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(createTable(db: DBTables.todoTable));
  }

  createTable({required DBTables db}) {
    return db.table.toCreate();
  }
}
