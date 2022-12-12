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
  }

  final WalletRepositoryInterface _walletRepository;

  Future<void> _getWallet(WalletEventGet event, Emitter<WalletState> emit) async {
    emit(const WalletStateInitial());
    emit(const WalletStatePending());
    final wallet = await _walletRepository.getUserWallet(needUpdate: event.needUpdate);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (wallet != null) {
      emit(WalletStateLoaded(wallet: wallet));
    } else {
      emit(const WalletStateFailed(reason: "не удалось загрузить баланс"));
    }
  }
}
