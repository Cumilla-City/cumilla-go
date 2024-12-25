import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import sqflite ffi
import 'package:path/path.dart'; // Import path for database file location

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialize the database if it hasn't been initialized yet
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Open a database (using FFI)
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cumilla_go.db');
    
    return await databaseFactoryFfi.openDatabase(path);
  }
}
