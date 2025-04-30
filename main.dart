import 'dart:io';
import 'package:flutter/material.dart';
import 'galery.dart';
import 'news.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyAp());
}

class MyAp extends StatelessWidget {
  const MyAp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KUBGAU Apps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text(
          'Приложения КубГАУ',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children: [
            _AppCard(
              icon: Icons.article,
              label: 'Новости КубГАУ',
              color: Colors.green.shade600,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              ),
            ),
            _AppCard(
              icon: Icons.photo_library,
              label: 'Фотогалерея',
              color: Colors.blue.shade600,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const galery()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AppCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
