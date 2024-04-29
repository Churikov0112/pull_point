part of 'wallet_withdraw_money_bloc.dart';

abstract class WalletWithdrawMoneyState {
  const WalletWithdrawMoneyState();
}

class WalletWithdrawMoneyStateInitial extends WalletWithdrawMoneyState {
  const WalletWithdrawMoneyStateInitial();
}

class WalletWithdrawMoneyStatePending extends WalletWithdrawMoneyState {
  const WalletWithdrawMoneyStatePending();
}

class WalletWithdrawMoneyStateReady extends WalletWithdrawMoneyState {
  const WalletWithdrawMoneyStateReady();
}

class WalletWithdrawMoneyStateFailed extends WalletWithdrawMoneyState {
  final String reason;

  const WalletWithdrawMoneyStateFailed({
    required this.reason,
  });
}
