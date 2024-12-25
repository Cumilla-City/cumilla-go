import 'dart:convert';  // Import dart:convert to decode JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import for FFI initialization
import 'database_helper.dart';
import 'models/place.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SQLite based on platform
  if (!kIsWeb) {
    // Initialize for desktop/mobile
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(CumillaCityApp());
}

class CumillaCityApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cumilla City App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PlacesScreen(),
    );
  }
}

class PlacesScreen extends StatefulWidget {
  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  // Add list of features
  final List<Map<String, dynamic>> features = [
    {'icon': Icons.person, 'label': 'নাগরিক', 'color': Colors.blue},
    {'icon': Icons.home_work, 'label': 'হাউজিং', 'color': Colors.green},
    {'icon': Icons.local_hospital, 'label': 'স্বাস্থ্যসেবা', 'color': Colors.red},
    {'icon': Icons.school, 'label': 'শিক্ষা', 'color': Colors.orange},
    {'icon': Icons.business, 'label': 'ব্যবসা', 'color': Colors.purple},
    {'icon': Icons.directions_bus, 'label': 'পরিবহন', 'color': Colors.brown},
    {'icon': Icons.local_police, 'label': 'আইন-শৃঙ্খলা', 'color': Colors.indigo},
    {'icon': Icons.park, 'label': 'পার্ক', 'color': Colors.teal},
    {'icon': Icons.shopping_cart, 'label': 'শপিং', 'color': Colors.pink},
    {'icon': Icons.restaurant, 'label': 'রেস্টুরেন্ট', 'color': Colors.amber},
    {'icon': Icons.local_hospital, 'label': 'হাসপাতাল', 'color': Colors.red},
    {'icon': Icons.sports_soccer, 'label': 'খেলাধুলা', 'color': Colors.green},
    // Add more features as needed
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cumilla GO'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: features[index]['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  features[index]['icon'],
                  color: features[index]['color'],
                  size: 30,
                ),
              ),
              SizedBox(height: 4),
              Text(
                features[index]['label'],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
