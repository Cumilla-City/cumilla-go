import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cumilla_go.db');
    return openDatabase(path, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE landmarks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          description TEXT,
          latitude REAL,
          longitude REAL,
          category TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE emergency_contacts(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          type TEXT,
          phone_number TEXT
        )
      ''');
      await db.execute('''
        CREATE TABLE transport_routes(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          route_name TEXT,
          start_point TEXT,
          end_point TEXT,
          stops TEXT
        )
      ''');
    }, version: 1);
  }

  Future<void> insertSampleData() async {
    final db = await database;

    // Insert landmarks
    await db.insert('landmarks', {
      'name': 'Lalmai Hill',
      'description': 'A historic hill in Cumilla.',
      'latitude': 23.4618,
      'longitude': 91.1809,
      'category': 'Tourist Spot',
    });

    // Insert emergency contacts
    await db.insert('emergency_contacts', {
      'name': 'Police Station',
      'type': 'Police',
      'phone_number': '999',
    });

    // Insert transport routes
    await db.insert('transport_routes', {
      'route_name': 'Cumilla Bus Route',
      'start_point': 'Cumilla Station',
      'end_point': 'Dhaka Station',
      'stops': '["Cumilla", "Narsingdi", "Dhaka"]',
    });
  }

  // Method to get data from landmarks table
  Future<List<Map<String, dynamic>>> getLandmarks() async {
    final db = await database;
    return db.query('landmarks');
  }

  // Method to get emergency contacts
  Future<List<Map<String, dynamic>>> getEmergencyContacts() async {
    final db = await database;
    return db.query('emergency_contacts');
  }

  // Method to get transport routes
  Future<List<Map<String, dynamic>>> getTransportRoutes() async {
    final db = await database;
    return db.query('transport_routes');
  }
}
