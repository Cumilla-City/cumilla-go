import 'package:flutter/material.dart';
import 'db_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Map<String, dynamic>>> landmarks;
  late Future<List<Map<String, dynamic>>> emergencyContacts;
  late Future<List<Map<String, dynamic>>> transportRoutes;

  @override
  void initState() {
    super.initState();
    // Insert sample data on app start
    insertSampleData();
    landmarks = DatabaseHelper().getLandmarks();
    emergencyContacts = DatabaseHelper().getEmergencyContacts();
    transportRoutes = DatabaseHelper().getTransportRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cumilla Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cumilla Go'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<List<Map<String, dynamic>>>(
                future: landmarks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No landmarks found');
                  } else {
                    return Column(
                      children: snapshot.data!.map((landmark) {
                        return ListTile(
                          title: Text(landmark['name']),
                          subtitle: Text(landmark['description']),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              Divider(),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: emergencyContacts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No emergency contacts found');
                  } else {
                    return Column(
                      children: snapshot.data!.map((contact) {
                        return ListTile(
                          title: Text(contact['name']),
                          subtitle: Text('${contact['type']} - ${contact['phone_number']}'),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              Divider(),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: transportRoutes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No transport routes found');
                  } else {
                    return Column(
                      children: snapshot.data!.map((route) {
                        return ListTile(
                          title: Text(route['route_name']),
                          subtitle: Text('From: ${route['start_point']} To: ${route['end_point']}'),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> insertSampleData() async {
    final dbHelper = DatabaseHelper();
    await dbHelper.insertSampleData();
  }
}
