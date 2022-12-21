import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'wallet_history_event.dart';
part 'wallet_history_state.dart';

class WalletHistoryBloc extends Bloc<WalletHistoryEvent, WalletHistoryState> {
  WalletHistoryBloc({
    required WalletRepositoryInterface walletRepository,
  })  : _walletRepository = walletRepository,
        super(const WalletHistoryStateInitial()) {
    on<WalletHistoryEventGet>(_getWalletHistory);
    on<WalletHistoryEventReset>(_reset);
  }

  final WalletRepositoryInterface _walletRepository;

  Future<void> _getWalletHistory(WalletHistoryEventGet event, Emitter<WalletHistoryState> emit) async {
    emit(const WalletHistoryStatePending());
    final walletHistory = await _walletRepository.getUserWalletHistory();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (walletHistory != null) {
      emit(WalletHistoryStateLoaded(transactions: walletHistory));
      return;
    } else {
      emit(const WalletHistoryStateNoWallet());
      return;
    }
  }

  Future<void> _reset(WalletHistoryEventReset event, Emitter<WalletHistoryState> emit) async {
    await _walletRepository.getUserWalletHistory();
    emit(const WalletHistoryStateInitial());
  }
}
