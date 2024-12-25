import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class AppNavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cumilla GO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'কুমিল্লা শহরের সকল তথ্য এক অ্যাপে',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('হোম'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: Icon(Icons.place),
            title: Text('দর্শনীয় স্থান'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tourist-places');
            },
          ),
          ListTile(
            leading: Icon(Icons.local_hospital),
            title: Text('হাসপাতাল'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/hospitals');
            },
          ),
          ListTile(
            leading: Icon(Icons.brightness_6),
            title: Text('থিম পরিবর্তন'),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
} 