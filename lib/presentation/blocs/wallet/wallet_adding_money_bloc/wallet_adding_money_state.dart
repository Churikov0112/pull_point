part of 'wallet_adding_money_bloc.dart';

abstract class WalletAddingMoneyState {
  const WalletAddingMoneyState();
}

class WalletAddingMoneyStateInitial extends WalletAddingMoneyState {
  const WalletAddingMoneyStateInitial();
}

class WalletAddingMoneyStatePending extends WalletAddingMoneyState {
  const WalletAddingMoneyStatePending();
}

class WalletAddingMoneyStateReady extends WalletAddingMoneyState {
  const WalletAddingMoneyStateReady();
}

class WalletAddingMoneyStateFailed extends WalletAddingMoneyState {
  final String reason;

  const WalletAddingMoneyStateFailed({
    required this.reason,
  });
}
