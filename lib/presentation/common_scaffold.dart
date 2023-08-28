import 'package:adventure_quest/presentation/favorites.dart';
import 'package:adventure_quest/presentation/home.dart';

import 'package:flutter/material.dart';

class CommonScaffold extends StatefulWidget {
  const CommonScaffold({super.key});

  @override
  State<CommonScaffold> createState() => _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Home(),
    Favorites(),
  ];

  void _onItemTap(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure Quest'),
        centerTitle: true,
        elevation: 10,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 14,
        // selectedItemColor: Colors.black,
        elevation: 40,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            // backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            // backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
