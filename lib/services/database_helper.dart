import 'package:quran/model/spesific_surah.dart';
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

    String path = join(documentDirectory, 'verse.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    return db.execute(''' 
      CREATE TABLE verse(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        numberInSurah INTEGER,
        numberInQuran INTEGER,
        textArab TEXT,
        textLatin TEXT,
        translationIndo tEXT 
      )
    ''');
  }

  Future<List<Verse>> getVerse() async {
    Database db = await instance.database;
    var verse = await db.query('verse');

    List<Verse> verseList =
        verse.isEmpty ? [] : verse.map((e) => Verse.fromMap(e)).toList();

    return verseList;
  }

  Future<int> addVerse(Verse verse) async {
    Database db = await instance.database;

    return await db.insert('verse', verse.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deleteAll() async {
    Database db = await instance.database;

    return await db.delete('verse');
  }

  Future<int> deleteById(int id) async {
    Database db = await instance.database;

    return await db.delete(
      'verse',
      where: 'numberInQuran = ?',
      whereArgs: [id],
    );
  }
}
