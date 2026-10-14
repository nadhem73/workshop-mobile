import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Film.dart';

class DatabaseHelper {
  static const _databaseName = 'gstore.db';
  static const _databaseVersion = 1;
  static const tableFavorites = 'favorites';

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableFavorites (
            title TEXT PRIMARY KEY,
            image TEXT NOT NULL,
            description TEXT NOT NULL,
            price INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> insertFavorite(Film film) async {
    final db = await database;
    await db.insert(
      tableFavorites,
      {
        'title': film.title,
        'image': film.image,
        'description': film.description,
        'price': film.price,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(Film film) async {
    final db = await database;
    await db.delete(tableFavorites, where: 'title = ?', whereArgs: [film.title]);
  }

  Future<List<Film>> getFavorites() async {
    final db = await database;
    final rows = await db.query(tableFavorites);
    return rows
        .map((row) => Film(
              row['title'] as String,
              row['image'] as String,
              row['description'] as String,
              row['price'] as int,
            ))
        .toList();
  }
}
