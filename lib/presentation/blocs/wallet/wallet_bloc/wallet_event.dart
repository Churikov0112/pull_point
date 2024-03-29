part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class WalletEventGet extends WalletEvent {
  final bool needUpdate;

  const WalletEventGet({
    required this.needUpdate,
  });
}

class WalletEventReset extends WalletEvent {
  const WalletEventReset();
}
