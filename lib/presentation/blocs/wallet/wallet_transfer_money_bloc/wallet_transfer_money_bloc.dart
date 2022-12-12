import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'wallet_transfer_money_event.dart';
part 'wallet_transfer_money_state.dart';

class WalletTransferMoneyBloc extends Bloc<WalletTransferMoneyEvent, WalletTransferMoneyState> {
  WalletTransferMoneyBloc({
    required WalletRepositoryInterface walletRepository,
  })  : _walletRepository = walletRepository,
        super(const WalletTransferMoneyStateInitial()) {
    on<WalletTransferMoneyEventTransferMoney>(_transferMoney);
  }

  final WalletRepositoryInterface _walletRepository;

  Future<void> _transferMoney(
      WalletTransferMoneyEventTransferMoney event, Emitter<WalletTransferMoneyState> emit) async {
    emit(const WalletTransferMoneyStateInitial());
    emit(const WalletTransferMoneyStatePending());
    final successful = await _walletRepository.transferCoins(sum: event.sum, artistName: event.artistName);
    if (successful) {
      emit(const WalletTransferMoneyStateReady());
      BotToast.showText(text: "Пожертвование прошло успешно");
    } else {
      BotToast.showText(text: "Не удалось совершить пожертвование");
      emit(const WalletTransferMoneyStateFailed(reason: "Не удалось совершить пожертвование"));
    }
  }
}
