import 'package:sqflite/sqflite.dart';

class SqlDb {
  static Database? _db;
  
  Future<Database?> get database async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    }
    return _db;
  }

  Future<Database> initialDb() async {
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

  Future<void> _onCreate(Database db, int version) async {
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
        playListId INTEGER DEFAULT 0,
        createdAt INTEGER DEFAULT (strftime('%s', 'now')),
        updatedAt INTEGER DEFAULT (strftime('%s', 'now')),
        FOREIGN KEY (playListId) REFERENCES playlists(id) ON DELETE CASCADE
      )
    ''');
    
    await db.execute('''
      CREATE TABLE IF NOT EXISTS playlists (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
          syntax error in db.dart
        isCurrent INTEGER DEFAULT 0,
        isCompleted INTEGER DEFAULT 0,
        createdAt INTEGER DEFAULT (strftime('%s', 'now')),
        updatedAt INTEGER DEFAULT (strftime('%s', 'now')),
      
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Add upgrade logic here if needed
  }

  Future<List<Map<String, dynamic>>> readData(String sql, {List<Object?>? values = const []}) async {
    Database? mydb = await database;
    List<Map<String, dynamic>> response = await mydb!.rawQuery(sql, values);
    return response;
  }

  Future<int> insertData(String sql, {required List<Object?> values}) async {
    Database? mydb = await database;
    int response = await mydb!.rawInsert(sql, values);
    return response;
  }

  Future<int> deleteData(String sql,{required List<Object?> values}) async {
    Database? mydb = await database;
    int response = await mydb!.rawDelete(sql, values);
    return response;
  }

  Future<int> updateData(String sql,{required List<Object?> values}) async {
    Database? mydb = await database;
    int response = await mydb!.rawUpdate(sql,values );
    return response;
  }

  Future<int> updateVideoCompletionStatus(int videoId, int isCompleted) async {
    Database? mydb = await database;
    int response = await mydb!.update(
      'videos',
      {'isCompleted': isCompleted, 'updatedAt': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [videoId],
    );
    return response;
  }

  Future<int> updatePlaylistCompletionStatus(int playlistId, int isCompleted) async {
    Database? mydb = await database;
    int response = await mydb!.update(
      'playlists',
      {'isCompleted': isCompleted, 'updatedAt': DateTime.now().millisecondsSinceEpoch},
      where: 'id = ?',
      whereArgs: [playlistId],
    );
    return response;
  }

  // Add this method to close the database when done
  Future<void> close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}