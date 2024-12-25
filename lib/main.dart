import 'dart:convert';  // Import dart:convert to decode JSON
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Import for FFI initialization
import 'database_helper.dart';
import 'models/place.dart';

void main() {
  // Initialize the database factory for FFI support
  databaseFactory = databaseFactoryFfi;

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
  late Future<List<Place>> places;

  @override
  void initState() {
    super.initState();
    places = initializeData();
  }

  Future<List<Place>> initializeData() async {
    // First check if database is empty
    final dbPlaces = await DatabaseHelper.instance.getPlaces();
    if (dbPlaces.isEmpty) {
      // If empty, load from JSON and populate database
      String data = await rootBundle.loadString('assets/places.json');
      List jsonData = json.decode(data);
      List<Place> placeList = jsonData.map((json) => Place.fromJson(json)).toList();
      
      // Insert places into database
      for (var place in placeList) {
        await DatabaseHelper.instance.insertPlace(place);
      }
      
      return DatabaseHelper.instance.getPlaces();
    }
    
    // If database already has data, just return it
    return dbPlaces;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cumilla City Guide'),
      ),
      body: FutureBuilder<List<Place>>(
        future: places,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No places available.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final place = snapshot.data![index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    place.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(place.description),
                  leading: place.imageUrl.startsWith('http')
                      ? Image.network(
                          place.imageUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image_not_supported);
                          },
                        )
                      : Icon(Icons.place),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
