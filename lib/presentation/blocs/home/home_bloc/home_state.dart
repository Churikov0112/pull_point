part of 'home_bloc.dart';

abstract class HomeState {}

class HomeStateTabSelected extends HomeState {
  final int tabIndex;

  HomeStateTabSelected({
    required this.tabIndex,
  });
}
