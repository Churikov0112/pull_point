part of 'wallet_transfer_money_bloc.dart';

abstract class WalletTransferMoneyState extends Equatable {
  const WalletTransferMoneyState();

  @override
  List<Object> get props => [];
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
