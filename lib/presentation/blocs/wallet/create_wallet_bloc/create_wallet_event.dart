part of 'create_wallet_bloc.dart';

abstract class CreateWalletEvent {
  const CreateWalletEvent();
}

class CreateWalletEventCreate extends CreateWalletEvent {
  final String cardNumber;

  const CreateWalletEventCreate({
    required this.cardNumber,
  });
}
