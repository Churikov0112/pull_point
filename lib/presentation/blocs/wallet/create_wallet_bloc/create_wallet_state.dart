part of 'create_wallet_bloc.dart';

abstract class CreateWalletState {
  const CreateWalletState();
}

class CreateWalletStateInitial extends CreateWalletState {
  const CreateWalletStateInitial();
}

class CreateWalletStatePending extends CreateWalletState {
  const CreateWalletStatePending();
}

class CreateWalletStateCreated extends CreateWalletState {
  final WalletModel wallet;

  const CreateWalletStateCreated({
    required this.wallet,
  });
}

class CreateWalletStateFailed extends CreateWalletState {
  final String reason;

  const CreateWalletStateFailed({
    required this.reason,
  });
}
