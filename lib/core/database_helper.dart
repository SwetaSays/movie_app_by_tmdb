import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  _initDb() async {
    final path = join(await getDatabasesPath(), 'movies.db');
    return await openDatabase(path, version: 1,
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE movies (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT,
        isBookmarked INTEGER
      )
      ''');
    });
  }

  Future<void> insertMovie(Movie movie) async {
    final db = await database;
    await db.insert('movies', movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Movie>> getBookmarkedMovies() async {
    final db = await database;
    final maps = await db.query('movies', where: 'isBookmarked = ?', whereArgs: [1]);
    return List.generate(maps.length, (i) => Movie.fromMap(maps[i]));
  }

  Future<void> updateMovie(Movie movie) async {
    final db = await database;
    await db.update('movies', movie.toMap(),
        where: 'id = ?', whereArgs: [movie.id]);
  }
}
