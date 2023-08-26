import 'dart:io';

import 'package:live_trek/consts/db.dart';
import 'package:live_trek/model/live.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LiveDatabaseHelper {
  static final _databaseVersion = 1;

  LiveDatabaseHelper._privateConstructor();
  static final LiveDatabaseHelper instance = LiveDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    // _databaseがNULLか判定
    // NULLの場合、_initDatabaseを呼び出しデータベースの初期化し、_databaseに返す
    // NULLでない場合、そのまま_database変数を返す
    // これにより、データベースを初期化する処理は、最初にデータベースを参照するときにのみ実行されるようになります。
    // このような実装を「遅延初期化 (lazy initialization)」と呼びます。
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    // アプリケーションのドキュメントディレクトリのパスを取得
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // 取得パスを基に、データベースのパスを生成
    String path = join(documentsDirectory.path, liveTableName);
    // データベース接続
    return await openDatabase(path,
        version: _databaseVersion,
        // テーブル作成メソッドの呼び出し
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $liveTableName(
        id TEXT PRIMARY KEY,
        title TEXT,
        artist TEXT,
        performance_date TEXT,
        venue TEXT,
        open_time TEXT,
        start_time TEXT,
        image_url TEXT,
        setli_id INTEGER,
        memo TEXT
      )
    ''');
  }

  // static Future<Database> openDb() async {
  //   return await openDatabase(
  //     join(await getDatabasesPath(), liveFileName),
  //     onCreate: (db, version) {
  //       return db.execute('''
  //         CREATE TABLE $liveTableName(
  //           id INTEGER PRIMARY KEY AUTOINCREMENT,
  //           title TEXT,
  //           artist TEXT,
  //           performance_date TEXT,
  //           venue TEXT,
  //           open_time TEXT,
  //           start_time TEXT,
  //           image_url TEXT,
  //           setli_id INTEGER,
  //           memo TEXT
  //         )
  //       ''');
  //     },
  //     version: 1,
  //   );
  // }


  Future<void> insert(Live live) async {
    Database? db = await instance.database;
    await db!.insert(
      liveTableName,
      live.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  Future<List<Live>> read() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(liveTableName);
    return List.generate(maps.length, (index) {
      return Live(
        id: maps[index]['id'].toString(),
        title: maps[index]['title'],
        artist: maps[index]['artist'],
        performanceDate: DateTime.parse(maps[index]['performance_date']),
        venue: maps[index]['venue'],
        openTime: DateTime.parse(maps[index]['open_time']),
        startTime: DateTime.parse(maps[index]['start_time']),
        imageUrl: maps[index]['image_url'].toString(),
      );
    });
  }

  Future<void> update(Live live) async {
    Database? db = await instance.database;
    await db!.update(
      liveTableName,
      live.toMap(),
      where: 'id = ?',
      whereArgs: [live.id],
    );
    db.close();
  }

  Future<void> delete(String id) async {
    Database? db = await instance.database;
    await db!.delete(
      liveTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}