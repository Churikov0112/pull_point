import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeStateTabSelected(tabIndex: 0)) {
    on<HomeEventSelectTab>(_selectTab);
  }

  Future<void> _selectTab(HomeEventSelectTab event, Emitter<HomeState> emit) async {
    emit(HomeStateTabSelected(tabIndex: event.tabIndex));
  }
}
