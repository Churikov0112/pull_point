import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeStateTabSelected(tabIndex: 0)) {
    on<HomeEventSelectTab>(_selectTab);
  }

  Future<void> _selectTab(HomeEventSelectTab event, Emitter<HomeState> emit) async {
    emit(const HomeStateInitial());
    emit(HomeStateTabSelected(tabIndex: event.tabIndex));
  }
}
