part of 'wallet_transfer_money_bloc.dart';

abstract class WalletTransferMoneyState {
  const WalletTransferMoneyState();
}

class WalletTransferMoneyStateInitial extends WalletTransferMoneyState {
  const WalletTransferMoneyStateInitial();
}

class WalletTransferMoneyStatePending extends WalletTransferMoneyState {
  const WalletTransferMoneyStatePending();
}

class WalletTransferMoneyStateReady extends WalletTransferMoneyState {
  const WalletTransferMoneyStateReady();
}

class WalletTransferMoneyStateFailed extends WalletTransferMoneyState {
  final String reason;

  const WalletTransferMoneyStateFailed({
    required this.reason,
  });
}
