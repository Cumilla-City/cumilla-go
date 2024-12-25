import 'package:flutter/material.dart';
import '../models/navigation_model.dart';

class NavigationWidget extends StatefulWidget {
  final NavigationModel navigation;
  
  const NavigationWidget({
    Key? key,
    required this.navigation,
  }) : super(key: key);

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  String currentTheme = 'system';
  
  void _handleThemeChange(String theme) {
    setState(() {
      currentTheme = theme;
    });
    // Add your theme change implementation here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Home Button
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, '/'),
            icon: const Icon(Icons.home),
            label: const Text('Home'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),

          // Menu Button with Dropdown
          PopupMenuButton<String>(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.menu, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Menu', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            itemBuilder: (BuildContext context) => [
              // Contributor Profile Option
              PopupMenuItem<String>(
                value: 'contributor',
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Contributor Profile'),
                  onTap: () => Navigator.pushNamed(context, '/contributor'),
                ),
              ),
              
              // Theme Selection Options
              PopupMenuItem<String>(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Theme',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Light Mode
                    ListTile(
                      leading: const Icon(Icons.light_mode),
                      title: const Text('Light Mode'),
                      selected: currentTheme == 'light',
                      onTap: () => _handleThemeChange('light'),
                    ),
                    // Dark Mode
                    ListTile(
                      leading: const Icon(Icons.dark_mode),
                      title: const Text('Dark Mode'),
                      selected: currentTheme == 'dark',
                      onTap: () => _handleThemeChange('dark'),
                    ),
                    // System Mode
                    ListTile(
                      leading: const Icon(Icons.settings_suggest),
                      title: const Text('System Mode'),
                      selected: currentTheme == 'system',
                      onTap: () => _handleThemeChange('system'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
} 