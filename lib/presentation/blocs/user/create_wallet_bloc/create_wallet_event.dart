part of 'create_wallet_bloc.dart';

abstract class CreateWalletEvent extends Equatable {
  const CreateWalletEvent();

  @override
  List<Object> get props => [];
}

class CreateWalletEventCreate extends CreateWalletEvent {
  final String cardNumber;

  const CreateWalletEventCreate({
    required this.cardNumber,
  });
}
