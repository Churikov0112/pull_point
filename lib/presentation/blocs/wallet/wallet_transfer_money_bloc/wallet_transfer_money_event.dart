part of 'wallet_transfer_money_bloc.dart';

abstract class WalletTransferMoneyEvent extends Equatable {
  const WalletTransferMoneyEvent();

  @override
  List<Object> get props => [];
}

class WalletTransferMoneyEventTransferMoney extends WalletTransferMoneyEvent {
  final int sum;
  final String artistName;

  const WalletTransferMoneyEventTransferMoney({
    required this.sum,
    required this.artistName,
  });
}
