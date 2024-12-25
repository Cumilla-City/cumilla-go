import 'package:flutter/material.dart';
import '../screens/more_screen.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'হোম',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'আরও',
        ),
      ],
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoreScreen()),
          ).then((_) {
            setState(() {
              _selectedIndex = 0;
            });
          });
        }
      },
    );
  }
} 