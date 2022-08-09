import 'package:quran/model/bookmark_hadist.dart';
import 'package:quran/model/bookmark_verse.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var documentDirectory = await getDatabasesPath();

    String path = join(documentDirectory, 'bookmark.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE surah(
        number TEXT PRIMARY KEY,
        nameArab TEXT,
        nameIndo TEXT,
        translation TEXT,
        numberOfVerses INTEGER,
        preBismillah TEXT,
        revelation TEXT
      )
    ''');

    await db.execute(''' 
      CREATE TABLE verse(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        surah SURAH,
        surahName TEXT,
        numberInQuran TEXT,
        surahNumber INTEGER,
        numberOfVerseBookmarked INTEGER
      )
    ''');

    await db.execute(''' 
      CREATE TABLE hadist(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        idName TEXT,
        number INTEGER,
        name TEXT
      )
    ''');
  }

  Future<List<BookmarkVerse>> getVerse() async {
    Database db = await instance.database;
    var verse = await db.query('verse');

    List<BookmarkVerse> verseList = verse.isEmpty
        ? []
        : verse.map((e) => BookmarkVerse.fromMap(e)).toList();

    return verseList;
  }

  Future<List<BookmarkHadist>> getHadist() async {
    Database db = await instance.database;
    var hadist = await db.query('hadist');

    List<BookmarkHadist> hadistList = hadist.isEmpty
        ? []
        : hadist.map((e) => BookmarkHadist.fromMap(e)).toList();

    return hadistList;
  }

  Future<int> addVerse(BookmarkVerse verse) async {
    Database db = await instance.database;

    return await db.insert('verse', verse.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> addHadist(BookmarkHadist hadist) async {
    Database db = await instance.database;

    return await db.insert('hadist', hadist.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteAllVerse() async {
    Database db = await instance.database;

    return await db.delete('verse');
  }

  Future<int> deleteAllHadist() async {
    Database db = await instance.database;

    return await db.delete('hadist');
  }

  Future<int> deleteVerseById(String id) async {
    Database db = await instance.database;

    return await db.delete(
      'verse',
      where: 'numberInQuran = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteHadistById(String idName, int number) async {
    Database db = await instance.database;

    return await db.delete(
      'hadist',
      where: 'idName = ? AND number = ?',
      whereArgs: [idName, number],
    );
  }
}
