import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../movie.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        title TEXT PRIMARY KEY,
        year TEXT,
        runtime TEXT,
        genre TEXT,
        director TEXT,
        actors TEXT,
        plot TEXT,
        language TEXT,
        country TEXT,
        awards TEXT,
        poster TEXT,
        imdbRating TEXT,
        type TEXT,
        images TEXT,
        totalSeasons INTEGER,
        comingSoon INTEGER
      )
    ''');
  }

  // ================= INSERT =================

  Future<void> insertMovies(List<Movie> movies) async {
    final db = await instance.database;

    final batch = db.batch();

    for (var movie in movies) {
      batch.insert(
        'movies',
        _movieToMap(movie),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  // ================= GET ALL =================

  Future<List<Movie>> getAllMovies() async {
    final db = await instance.database;

    final result = await db.query('movies');

    return result.map((map) => _mapToMovie(map)).toList();
  }

  // ================= SEARCH =================

  Future<List<Movie>> searchMovies(String query) async {
    final db = await instance.database;

    final result = await db.query(
      'movies',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );

    return result.map((map) => _mapToMovie(map)).toList();
  }

  // ================= MAPPERS =================

  Map<String, dynamic> _movieToMap(Movie movie) {
    return {
      'title': movie.title,
      'year': movie.year,
      'runtime': movie.runtime,
      'genre': movie.genre,
      'director': movie.director,
      'actors': movie.actors,
      'plot': movie.plot,
      'language': movie.language,
      'country': movie.country,
      'awards': movie.awards,
      'poster': movie.poster,
      'imdbRating': movie.imdbRating,
      'type': movie.type,
      'images': movie.images != null ? jsonEncode(movie.images) : null,
      'totalSeasons': movie.totalSeasons,
      'comingSoon': movie.comingSoon == true ? 1 : 0,
    };
  }

  Movie _mapToMovie(Map<String, dynamic> map) {
    return Movie(
      title: map['title'],
      year: map['year'],
      runtime: map['runtime'],
      genre: map['genre'],
      director: map['director'],
      actors: map['actors'],
      plot: map['plot'],
      language: map['language'],
      country: map['country'],
      awards: map['awards'],
      poster: map['poster'],
      imdbRating: map['imdbRating'],
      type: map['type'],
      images: map['images'] != null
          ? List<String>.from(jsonDecode(map['images']))
          : null,
      totalSeasons: map['totalSeasons'],
      comingSoon: map['comingSoon'] == 1,
    );
  }
}