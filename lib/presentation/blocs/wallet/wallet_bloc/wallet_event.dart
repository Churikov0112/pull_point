part of 'wallet_bloc.dart';

abstract class WalletEvent {
  const WalletEvent();
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
