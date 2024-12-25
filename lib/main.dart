import 'dart:convert';  // Import dart:convert to decode JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import for FFI initialization
import 'database_helper.dart';
import 'models/place.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'widgets/navigation_drawer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize SQLite based on platform
  if (!kIsWeb) {
    // Initialize for desktop/mobile
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Cumilla City App',
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,  // Add this for Material 3 design
          ),
          darkTheme: ThemeData.dark(),
          initialRoute: '/',
          routes: {
            '/': (context) => PlacesScreen(),
            '/tourist-places': (context) => TouristPlacesScreen(),
            '/hospitals': (context) => HospitalsScreen(),
          },
        );
      },
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
    {'icon': Icons.local_hospital, 'label': 'হাপাতাল', 'color': Colors.red},
    {'icon': Icons.sports_soccer, 'label': 'খেলাধুলা', 'color': Colors.green},
    // Add more features as needed
  ];

  void _navigateToFeature(BuildContext context, String label) {
    Widget screen;
    switch (label) {
      case 'নাগরিক':
        screen = DonorListScreen();
        break;
      case 'দর্শনীয় স্থান':
        screen = TouristPlacesScreen();
        break;
      case 'আইন-শৃঙ্খলা':
        screen = PoliceStationsScreen();
        break;
      // Add more cases for other features
      default:
        screen = Scaffold(
          appBar: AppBar(title: Text(label)),
          body: Center(child: Text('$label কনটেন্ট শীঘ্রই আসছে')),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      drawer: AppNavigationDrawer(),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _navigateToFeature(context, features[index]['label']),
            child: Column(
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
            ),
          );
        },
      ),
    );
  }
}

class DonorListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ডোনার তালিকা')),
      body: ListView(
        children: [
          // Donor list items will go here
        ],
      ),
    );
  }
}

class TouristPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('দর্শনীয় স্থান')),
      body: GridView.builder(
        // Tourist places grid
        itemCount: 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) => Container(),
      ),
    );
  }
}

class PoliceStationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('পুলিশ স্টেশন')),
      body: ListView(
        children: [
          // Police station list items will go here
        ],
      ),
    );
  }
}

class HospitalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('হাসপাতাল')),
      body: ListView(
        children: [
          // Hospital list items will go here
        ],
      ),
    );
  }
}
