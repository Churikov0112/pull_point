import 'package:flutter/material.dart' show Scaffold, BottomNavigationBar, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';

import '../feed/feed.dart';
import '../map/map.dart';
import '../profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late MapController mapController;

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _currentScreen() {
    switch (_selectedIndex) {
      case 0:
        return const MapScreen();
      case 1:
        return const FeedScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const Text("Ошибка навигации. См. home_page.dart");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Карта',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feed_outlined),
            label: 'Афиши',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Профиль',
          ),
        ],
      ),
      body: Center(child: _currentScreen()),
    );
  }
}
