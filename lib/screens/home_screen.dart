import 'package:flutter/material.dart';
import 'package:glowup_app/pages/fitness_page.dart';
import 'package:glowup_app/pages/glowup_page.dart';
import 'package:glowup_app/pages/mind_page.dart';
import 'package:glowup_app/pages/profile_page.dart';
import 'package:glowup_app/pages/progress_page.dart';
import 'package:glowup_app/pages/style_page.dart';

import '../pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    GlowUpPage(),
    FitnessPage(),
    StylePage(),
    MindPage(),
    ProgressPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.red,
        // fixedColor: Colors.amber,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Colors.red, ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Glow-Up',
            // backgroundColor: Colors.red, 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Fitness',
            backgroundColor: Colors.red, 
          ),
          BottomNavigationBarItem(icon: Icon(Icons.style), label: 'Style',backgroundColor: Colors.red, ),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'Mind',backgroundColor: Colors.red, ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Progress',
            backgroundColor: Colors.red, 
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',backgroundColor: Colors.red, ),
        ],
      ),
    );
  }
}
