import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'wallet_adding_money_event.dart';
part 'wallet_adding_money_state.dart';

class WalletAddingMoneyBloc extends Bloc<WalletAddingMoneyEvent, WalletAddingMoneyState> {
  WalletAddingMoneyBloc({
    required WalletRepositoryInterface walletRepository,
  })  : _walletRepository = walletRepository,
        super(const WalletAddingMoneyStateInitial()) {
    on<WalletAddingMoneyEventAddMoney>(_addMoney);
  }

  final WalletRepositoryInterface _walletRepository;

  Future<void> _addMoney(WalletAddingMoneyEventAddMoney event, Emitter<WalletAddingMoneyState> emit) async {
    emit(const WalletAddingMoneyStatePending());
    final successful = await _walletRepository.buyCoins(sum: event.shopItem.sum);
    if (successful) {
      emit(const WalletAddingMoneyStateReady());
      BotToast.showText(text: "Кошелек успешно пополнен");
    } else {
      BotToast.showText(text: "Не удалось пополнить кошелек");
      emit(const WalletAddingMoneyStateFailed(reason: "Не удалось пополнить кошелек"));
    }
    // emit(const WalletAddingMoneyStateInitial());
  }
}
