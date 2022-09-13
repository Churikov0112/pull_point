part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeStateInitial extends HomeState {
  const HomeStateInitial();
}

class HomeStateTabSelected extends HomeState {
  final int tabIndex;

  const HomeStateTabSelected({
    required this.tabIndex,
  });
}
