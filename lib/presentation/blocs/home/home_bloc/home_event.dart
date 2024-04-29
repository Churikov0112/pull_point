part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class HomeEventSelectTab extends HomeEvent {
  final int tabIndex;

  const HomeEventSelectTab({
    required this.tabIndex,
  });
}
