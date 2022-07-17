import 'package:flutter/material.dart' show Scaffold, BottomNavigationBar, Icons;
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../feed/feed.dart';
import '../map/map.dart';
import '../profile/profile.dart';
import 'blocs/blocs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MapController mapController;

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  void _onItemTapped(int index) {
    context.read<HomeBloc>().add(SelectTabEvent(tabIndex: index));
  }

  Widget _currentScreen({required int index}) {
    switch (index) {
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is TabSelectedState) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.tabIndex,
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
            body: Center(child: _currentScreen(index: state.tabIndex)),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
