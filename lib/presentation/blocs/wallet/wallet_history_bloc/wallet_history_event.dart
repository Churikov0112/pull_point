part of 'wallet_history_bloc.dart';

abstract class WalletHistoryEvent extends Equatable {
  const WalletHistoryEvent();

  @override
  List<Object> get props => [];
}

class WalletHistoryEventGet extends WalletHistoryEvent {
  final bool needUpdate;

  const WalletHistoryEventGet({
    required this.needUpdate,
  });
}

class WalletHistoryEventReset extends WalletHistoryEvent {
  const WalletHistoryEventReset();
}
