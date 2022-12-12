part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeEventSelectTab extends HomeEvent {
  final int tabIndex;

  const HomeEventSelectTab({
    required this.tabIndex,
  });
}
