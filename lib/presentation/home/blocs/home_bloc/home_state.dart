part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class InitialState extends HomeState {
  const InitialState();
}

class TabSelectedState extends HomeState {
  final int tabIndex;

  const TabSelectedState({
    required this.tabIndex,
  });
}