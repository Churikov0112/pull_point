part of 'wallet_adding_money_bloc.dart';

abstract class WalletAddingMoneyEvent {
  const WalletAddingMoneyEvent();
}

class WalletAddingMoneyEventAddMoney extends WalletAddingMoneyEvent {
  final ShopItemModel shopItem;

  const WalletAddingMoneyEventAddMoney({
    required this.shopItem,
  });
}
