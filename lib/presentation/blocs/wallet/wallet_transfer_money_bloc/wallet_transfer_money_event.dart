part of 'wallet_transfer_money_bloc.dart';

abstract class WalletTransferMoneyEvent {
  const WalletTransferMoneyEvent();
}

class WalletTransferMoneyEventTransferMoney extends WalletTransferMoneyEvent {
  final int sum;
  final String artistName;

  const WalletTransferMoneyEventTransferMoney({
    required this.sum,
    required this.artistName,
  });
}
