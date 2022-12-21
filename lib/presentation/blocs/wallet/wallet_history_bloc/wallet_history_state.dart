part of 'wallet_history_bloc.dart';

abstract class WalletHistoryState extends Equatable {
  const WalletHistoryState();

  @override
  List<Object> get props => [];
}

class WalletHistoryStateInitial extends WalletHistoryState {
  const WalletHistoryStateInitial();
}

class WalletHistoryStatePending extends WalletHistoryState {
  const WalletHistoryStatePending();
}

class WalletHistoryStateLoaded extends WalletHistoryState {
  final List<TransactionModel>? transactions;

  const WalletHistoryStateLoaded({
    required this.transactions,
  });
}

class WalletHistoryStateNoWallet extends WalletHistoryState {
  const WalletHistoryStateNoWallet();
}

class WalletHistoryStateFailed extends WalletHistoryState {
  final String reason;

  const WalletHistoryStateFailed({
    required this.reason,
  });
}
