part of 'wallet_adding_money_bloc.dart';

abstract class WalletAddingMoneyEvent extends Equatable {
  const WalletAddingMoneyEvent();

  @override
  List<Object> get props => [];
}

class WalletAddingMoneyEventAddMoney extends WalletAddingMoneyEvent {
  final ShopItemModel shopItem;

  const WalletAddingMoneyEventAddMoney({
    required this.shopItem,
  });
}
