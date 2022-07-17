import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const TabSelectedState(tabIndex: 0)) {
    on<SelectTabEvent>(_selectTab);
  }

  Future<void> _selectTab(SelectTabEvent event, Emitter<HomeState> emit) async {
    emit(const InitialState());
    emit(TabSelectedState(tabIndex: event.tabIndex));
  }
}
