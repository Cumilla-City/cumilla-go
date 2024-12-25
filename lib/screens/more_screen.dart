import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/theme_provider.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('আরও'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildListTile(
            context,
            icon: Icons.brightness_6,
            title: 'থিম পরিবর্তন',
            subtitle: 'লাইট এবং ডার্ক মোড পরিবর্তন করুন',
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
          _buildListTile(
            context,
            icon: Icons.people,
            title: 'কন্ট্রিবিউটরস',
            subtitle: 'অ্যাপ ডেভেলপারদের সম্পর্কে জানুন',
            onTap: () async {
              final Uri url = Uri.parse('https://cv-irfan-hasan.vercel.app/');
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              }
            },
          ),
          _buildListTile(
            context,
            icon: Icons.info,
            title: 'অ্যাপ সম্পর্কে',
            subtitle: 'ভার্সন ১.০.০',
            onTap: () {
              // Show about dialog or navigate to about page
            },
          ),
          _buildListTile(
            context,
            icon: Icons.share,
            title: 'শেয়ার করুন',
            subtitle: 'অন্যদের সাথে অ্যাপটি শেয়ার করুন',
            onTap: () {
              // Implement share functionality
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
} 