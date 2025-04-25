import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:onlinelearning/common/index.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';

class DataBaseService extends GetxService {
  static DataBaseService get to => Get.find();

  static const _kDatabaseName = 'sqlite.db';
  static const _kDatabaseVerion = 1;
  static const _kSearchHistoryTable = 'search_history';
  static const _kVideoProgressTable = 'video_progress';
  static const _kKeyValueStoreTable = 'key_value_store';

  static late BriteDatabase _streamDatabase;

  static var lock = Lock();
  static Database? _databse;

  Future _onCreate(Database db, int verion) async {
    await db.execute(
      '''
          CREATE TABLE $_kSearchHistoryTable (
            user_id INTEGER NOT NULL,
            search_text TEXT NOT NULL,
            search_time DATETIME DEFAULT (datetime('now')),
            PRIMARY KEY (user_id, search_text)
          )
      ''',
    );

    await db.execute(
      '''
          CREATE TABLE $_kVideoProgressTable (
            user_id INTEGER NOT NULL,
            video_id INTEGER NOT NULL,
            course_id INTEGER NOT NULL,
            duration INTEGER NOT NULL,
            progress REAL NOT NULL,
            PRIMARY KEY (user_id, video_id)
          )
      ''',
    );

    await db.execute(
      '''
          CREATE TABLE $_kKeyValueStoreTable (
            user_id INTEGER NOT NULL,
            key TEXT NOT NULL,
            string_valaue TEXT,
            integer_value INTEGER,
            real_value    REAL,
            PRIMARY KEY (user_id, key)
          )
      ''',
    );
  }

  Future<Database> _initDatabase() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, _kDatabaseName);

    // ignore: deprecated_member_use
    Sqflite.devSetDebugModeOn(kDebugMode);

    return openDatabase(
      path,
      version: _kDatabaseVerion,
      onCreate: _onCreate,
    );
  }

  Future<Database> get database async {
    if (_databse != null) {
      return _databse!;
    }

    await lock.synchronized(
      () async {
        if (_databse == null) {
          _databse = await _initDatabase();
          _streamDatabase = BriteDatabase(_databse!);
        }
      },
    );

    return _databse!;
  }

  // 获取流数据库
  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  /// 初始化
  @override
  Future<void> onInit() async {
    super.onInit();
    await database;
  }

  // 插入搜索历史记录
  Future<void> insertSearchText(String text) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return;
    }

    await _streamDatabase.insert(
      _kSearchHistoryTable,
      {
        'user_id': uid,
        'search_text': text,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<String>> getSearchHistories() async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return [];
    }
    final rows = await _streamDatabase.query(
      _kSearchHistoryTable,
      where: 'user_id = ?',
      whereArgs: [uid],
      orderBy: 'search_time DESC',
      limit: 10,
    );
    final results = <String>[];
    for (final row in rows) {
      results.add(row['search_text'] as String);
    }
    return results;
  }

  Future<void> clearSearchHistories() async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return;
    }
    await _streamDatabase.delete(
      _kSearchHistoryTable,
      where: 'user_id = ?',
      whereArgs: [uid],
    );
  }

  Future<void> setVideoProgress(
      int videoId, int courseId, int duration, double progress) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return;
    }

    if (progress == double.infinity || progress.isNaN) {
      return;
    }

    await _streamDatabase.insert(
      _kVideoProgressTable,
      {
        'user_id': uid,
        'video_id': videoId,
        'course_id': courseId,
        'duration': duration,
        'progress': progress,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int?> getLearnedCourseDuration(int courseId) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return null;
    }

    const sql = '''
      SELECT SUM(duration) AS duration
      FROM $_kVideoProgressTable
      WHERE user_id = ? AND course_id = ?
      ''';
    final maps = await _streamDatabase.rawQuery(sql, [uid, courseId]);
    if (maps.isNotEmpty) {
      return maps.first['duration'] as int;
    } else {
      return null;
    }
  }

  Future<double?> getVideoProgress(int videoId) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return null;
    }

    final maps = await _streamDatabase.query(
      _kVideoProgressTable,
      where: 'user_id = ? AND video_id = ?',
      whereArgs: [uid, videoId],
    );

    if (maps.isNotEmpty) {
      return maps.first['progress'] as double;
    } else {
      return null;
    }
  }

  Future<void> setKeyValue(
    String key, {
    String? string,
    int? integer,
    double? real,
  }) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return;
    }

    await _streamDatabase.insert(
      _kKeyValueStoreTable,
      {
        'user_id': uid,
        'key': key,
        'string_valaue': string,
        'integer_value': integer,
        'real_value': real,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getStringValue(String key) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return null;
    }

    final maps = await _streamDatabase.query(
      _kKeyValueStoreTable,
      where: 'user_id = ? AND key = ?',
      whereArgs: [uid, key],
    );

    if (maps.isNotEmpty) {
      return maps.first['string_valaue'] as String;
    } else {
      return null;
    }
  }

  Future<int?> getIntegerValue(String key) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return null;
    }

    final maps = await _streamDatabase.query(
      _kKeyValueStoreTable,
      where: 'user_id = ? AND key = ?',
      whereArgs: [uid, key],
    );

    if (maps.isNotEmpty) {
      return maps.first['integer_value'] as int;
    } else {
      return null;
    }
  }

  Future<double?> getRealValue(String key) async {
    final uid = UserService.to.accountId;
    if (uid == null) {
      return null;
    }

    final maps = await _streamDatabase.query(
      _kKeyValueStoreTable,
      where: 'user_id = ? AND key = ?',
      whereArgs: [uid, key],
    );

    if (maps.isNotEmpty) {
      return maps.first['real_value'] as double;
    } else {
      return null;
    }
  }
}
