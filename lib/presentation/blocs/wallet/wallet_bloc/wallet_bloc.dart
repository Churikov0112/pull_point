import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc({
    required WalletRepositoryInterface walletRepository,
  })  : _walletRepository = walletRepository,
        super(const WalletStateInitial()) {
    on<WalletEventGet>(_getWallet);
    on<WalletEventReset>(_reset);
  }

  final WalletRepositoryInterface _walletRepository;

  Future<void> _getWallet(WalletEventGet event, Emitter<WalletState> emit) async {
    emit(const WalletStatePending());
    final wallet = await _walletRepository.getUserWallet();
    await Future.delayed(const Duration(milliseconds: 1000));
    if (wallet != null) {
      emit(WalletStateLoaded(wallet: wallet));
      return;
    } else {
      emit(const WalletStateNoWallet());
      return;
    }
  }

  Future<void> _reset(WalletEventReset event, Emitter<WalletState> emit) async {
    await _walletRepository.getUserWallet();
    emit(const WalletStateInitial());
  }
}
