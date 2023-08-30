import 'dart:io';

import 'package:live_trek/consts/db.dart';
import 'package:live_trek/model/setlist.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SetlistDatabaseHelper {
  static final _databaseVersion = 1;

  SetlistDatabaseHelper._privateConstructor();
  static final SetlistDatabaseHelper instance = SetlistDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    // _databaseがNULLか判定
    // NULLの場合、_initDatabaseを呼び出しデータベースの初期化し、_databaseに返す
    // NULLでない場合、そのまま_database変数を返す
    // これにより、データベースを初期化する処理は、最初にデータベースを参照するときにのみ実行されるようになります。
    // このような実装を「遅延初期化 (lazy initialization)」と呼びます。
    // if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    // アプリケーションのドキュメントディレクトリのパスを取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 取得パスを基に、データベースのパスを生成
    String path = join(documentsDirectory.path, setlistTableName);
    // データベース接続
    return await openDatabase(path,
        version: _databaseVersion,
        // テーブル作成メソッドの呼び出し
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $setlistTableName(
        id TEXT PRIMARY KEY,
        live_id TEXT,
        song_order INTEGER,
        song_title TEXT,
        artist_name TEXT,
        notes TEXT
      )
    ''');
  }



  Future<void> insert(Setlist setlist) async {
    Database? db = await instance.database;
    await db!.insert(
      setlistTableName,
      setlist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Setlist>> read() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(setlistTableName);
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

  Future<void> update(Setlist setlist) async {
    Database? db = await instance.database;
    await db!.update(
      setlistTableName,
      setlist.toMap(),
      where: 'id = ?',
      whereArgs: [setlist.id],
    );
    db.close();
  }

  Future<void> delete(String id) async {
    Database? db = await instance.database;
    await db!.delete(
      setlistTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}