import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/place.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  List<Place> _webPlaces = []; // For web platform

  DatabaseHelper._init();

  Future<Database> get database async {
    if (kIsWeb) {
      throw UnsupportedError('Web platform does not support SQLite');
    }
    
    if (_database != null) return _database!;
    _database = await _initDB('places.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE places(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        imageUrl TEXT NOT NULL,
        latitude REAL NOT NULL,
        longitude REAL NOT NULL
      )
    ''');
  }

  Future<void> insertPlace(Place place) async {
    if (kIsWeb) {
      _webPlaces.add(place);
      return;
    }
    
    final db = await database;
    await db.insert(
      'places',
      place.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Place>> getPlaces() async {
    if (kIsWeb) {
      return _webPlaces;
    }
    
    final db = await database;
    final result = await db.query('places');
    return result.map((json) => Place.fromJson(json)).toList();
  }

  Future<bool> isDatabaseEmpty() async {
    if (kIsWeb) {
      return _webPlaces.isEmpty;
    }
    
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM places'));
    return count == 0;
  }
}
