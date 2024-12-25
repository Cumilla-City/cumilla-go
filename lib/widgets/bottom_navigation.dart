import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/theme_provider.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
        if (index == 1) {
          _showMoreOptions(context);
        }
      },
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.brightness_6),
                title: Text('থিম পরিবর্তন'),
                onTap: () {
                  Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.people),
                title: Text('কন্ট্রিবিউটরস'),
                onTap: () async {
                  final Uri url = Uri.parse('https://cv-irfan-hasan.vercel.app/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
} 