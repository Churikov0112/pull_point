import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';
import 'package:pull_point/presentation/profile/ui/screens/finance/shop_list/shop_item.dart';

part 'wallet_withdraw_money_event.dart';
part 'wallet_withdraw_money_state.dart';

class WalletWithdrawMoneyBloc extends Bloc<WalletWithdrawMoneyEvent, WalletWithdrawMoneyState> {
  WalletWithdrawMoneyBloc({
    required WalletRepositoryInterface walletRepository,
  })  : _walletRepository = walletRepository,
        super(const WalletWithdrawMoneyStateInitial()) {
    on<WalletWithdrawMoneyEventWithdrawMoney>(_withdrawMoney);
  }

  final WalletRepositoryInterface _walletRepository;

  Future<void> _withdrawMoney(
      WalletWithdrawMoneyEventWithdrawMoney event, Emitter<WalletWithdrawMoneyState> emit) async {
    emit(const WalletWithdrawMoneyStateInitial());
    emit(const WalletWithdrawMoneyStatePending());
    final successful = await _walletRepository.sellCoins(sum: event.sum);
    if (successful) {
      emit(const WalletWithdrawMoneyStateReady());
      BotToast.showText(text: "Деньги успешно выведены на карту");
    } else {
      BotToast.showText(text: "Не удалось вывести деньги");
      emit(const WalletWithdrawMoneyStateFailed(reason: "Не удалось вывести деньги"));
    }
    // emit(const WalletWithdrawMoneyStateInitial());
  }
}
