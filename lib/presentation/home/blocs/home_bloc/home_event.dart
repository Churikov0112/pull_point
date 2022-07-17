part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SelectTabEvent extends HomeEvent {
  final int tabIndex;

  const SelectTabEvent({
    required this.tabIndex,
  });
}
