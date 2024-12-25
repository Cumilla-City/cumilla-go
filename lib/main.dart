import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'db_helper.dart';

void main() {
  // Initialize the sqflite databaseFactory for ffi
  databaseFactory = databaseFactoryFfi;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cumilla Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    insertSampleData();
  }

  Future<void> insertSampleData() async {
    try {
      final db = await DatabaseHelper.instance.database;
      print('Database initialized: $db');

      // Insert landmarks
      await db.insert('landmarks', {
        'name': 'Lalmai Hill',
        'description': 'A historic hill in Cumilla.',
        'latitude': 23.4618,
        'longitude': 91.1809,
        'category': 'Tourist Spot',
      });

      print('Landmark inserted');

      // Insert emergency contacts
      await db.insert('emergency_contacts', {
        'name': 'Police Station',
        'type': 'Police',
        'phone_number': '999',
      });

      print('Emergency contact inserted');

      // Insert transport routes
      await db.insert('transport_routes', {
        'route_name': 'Cumilla Bus Route',
        'start_point': 'Cumilla Station',
        'end_point': 'Dhaka Station',
        'stops': '["Cumilla", "Narsingdi", "Dhaka"]',
      });

      print('Transport route inserted');
    } catch (e) {
      print("Error inserting sample data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cumilla Go'),
      ),
      body: Center(
        child: Text('Welcome to Cumilla Go!'),
      ),
    );
  }
}
