import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';
import 'package:pull_point/presentation/profile/ui/screens/balance/shop_list/shop_item.dart';

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
    emit(const WalletAddingMoneyStateInitial());
    emit(const WalletAddingMoneyStatePending());
    final successful = await _walletRepository.buyCoins(sum: event.shopItem.sum);
    if (successful) {
      emit(const WalletAddingMoneyStateReady());
    } else {
      BotToast.showText(text: "Не удалось пополнить кошелек");
      emit(const WalletAddingMoneyStateFailed(reason: "Не удалось пополнить кошелек"));
    }
    // emit(const WalletAddingMoneyStateInitial());
  }
}
