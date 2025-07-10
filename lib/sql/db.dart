import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;
  Future<Database?> get database async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    }else{
    return _db;

    }
    
  }

  initialDb() async {
    String dbPath = await getDatabasesPath();
    String dbName = "trucker.db";
    String path = "$dbPath/$dbName";

    Database mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      version: 1,
    );
    return mydb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS videos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        currentHours INTEGER,
        currentMinutes INTEGER,
        currentSeconds INTEGER,
        totalHours INTEGER,
        totalMinutes INTEGER,
        totalSeconds INTEGER,
        isCurrent INTEGER DEFAULT 0,
        isCompleted INTEGER DEFAULT 0,
        createdAt INTEGER DEFAULT (strftime('%s', 'now')),
        updatedAt INTEGER DEFAULT (strftime('%s', 'now')),
      )
    ''');
    await db.execute('''
   CREATE TABLE IF NOT EXISTS playlits (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        videoId INTEGER,
        isCurrent INTEGER DEFAULT 0,
        isCompleted INTEGER DEFAULT 0,
        createdAt INTEGER DEFAULT (strftime('%s', 'now')),
        updatedAt INTEGER DEFAULT (strftime('%s', 'now')),
        FOREIGN KEY (videoId) REFERENCES videos(id) ON DELETE CASCADE
      
   )
''');
  }

  
  _onUpgrade(Database db, int oldVersion, int newVersion) async {

  }

  readData(String sql) async {
    Database? mydb = await database;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }
 Future<int>  writeData(String sql) async {
    Database? mydb = await database;
    int response = await mydb!.rawInsert(sql);
    return response;
  }
 Future<int> deleteData(String sql) async {
    Database? mydb = await database;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

 Future<int> updateData(String sql) async {
    Database? mydb = await database;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }
}
