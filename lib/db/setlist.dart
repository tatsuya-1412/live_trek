import 'package:live_trek/consts/db.dart';
import 'package:live_trek/model/setlist.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SetlistDb {
  static Future<Database> openDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), setlistFileName),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $setlistTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            live_id INTEGER,
            song_order INTEGER,
            song_title TEXT,
            artist_name TEXT,
            notes TEXT
          )
        ''');
      },
      version: 1,
    );
  }


  static Future<void> insert(Setlist setlist) async {
    var db = await openDb();
    await db.insert(
      setlistTableName,
      setlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Setlist>> read() async {
    var db = await openDb();
    final List<Map<String, dynamic>> maps = await db.query(setlistTableName);
    return List.generate(maps.length, (index) {
      return Setlist(
        id: maps[index]['id'],
        liveId: maps[index]['live_id'],
        songOrder: maps[index]['song_order'],
        songTitle: maps[index]['song_title'],
        artistName: maps[index]['artist_name'],
        notes: maps[index]['notes'],
      );
    });
  }

  static Future<void> update(Setlist setlist) async {
    var db = await openDb();
    await db.update(
      setlistTableName,
      setlist.toMap(),
      where: 'id = ?',
      whereArgs: [setlist.id],
    );
    db.close();
  }

  static Future<void> delete(int id) async {
    var db = await openDb();
    await db.delete(
      setlistTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}