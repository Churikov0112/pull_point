import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:pull_point/presentation/favourites/ui/screens/screens.dart';
import 'package:pull_point/presentation/qr_reader/ui/screens/qr_reader/qr_reader.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

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
        return const QrReaderScreen();
      case 3:
        return const FavouritesScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const Text("Ошибка навигации. См. home_page.dart");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is TabSelectedState) {
            return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                // showSelectedLabels: false,
                // showUnselectedLabels: false,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.primary,
                // unselectedItemColor: Colors.grey,
                unselectedFontSize: 0,
                selectedFontSize: 0,
                currentIndex: state.tabIndex,
                onTap: (index) => _onItemTapped(index),
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.place_outlined),
                    activeIcon: Icon(Icons.place),
                    label: 'Карта',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.feed_outlined),
                    activeIcon: Icon(Icons.feed),
                    label: 'Афиши',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppGradients.main),
                      child: const Center(child: Icon(Icons.qr_code, size: 20, color: AppColors.iconsOnColors)),
                    ), // Icon(Icons.qr_code_2),
                    label: 'QR',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.star_border_outlined),
                    activeIcon: Icon(Icons.star),
                    label: 'Избранное',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Профиль',
                  ),
                ],
              ),
              body: Center(child: _currentScreen(index: state.tabIndex)),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
