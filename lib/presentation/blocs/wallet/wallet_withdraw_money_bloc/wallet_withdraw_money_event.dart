part of 'wallet_withdraw_money_bloc.dart';

abstract class WalletWithdrawMoneyEvent extends Equatable {
  const WalletWithdrawMoneyEvent();

  @override
  List<Object> get props => [];
}

class WalletWithdrawMoneyEventWithdrawMoney extends WalletWithdrawMoneyEvent {
  final int sum;

  const WalletWithdrawMoneyEventWithdrawMoney({
    required this.sum,
  });
}
