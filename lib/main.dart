import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper().database; // Initialize the database
  runApp(CumillaGoApp());
}

class CumillaGoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cumilla Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Landmarks', 'icon': Icons.location_on},
    {'name': 'Emergency', 'icon': Icons.phone},
    {'name': 'Transport', 'icon': Icons.directions_bus},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cumilla Go'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: Icon(category['icon']),
            title: Text(category['name']),
            onTap: () {
              // Navigate to respective screens
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(category: category['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String category;

  const CategoryScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: Center(
        child: Text('Content for $category will be displayed here.'),
      ),
    );
  }
}
