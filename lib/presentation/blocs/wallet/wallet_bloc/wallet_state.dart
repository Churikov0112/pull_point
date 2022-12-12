part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletStateInitial extends WalletState {
  const WalletStateInitial();
}

class WalletStatePending extends WalletState {
  const WalletStatePending();
}

class WalletStateLoaded extends WalletState {
  final WalletModel? wallet;

  const WalletStateLoaded({
    required this.wallet,
  });
}

class WalletStateNoWallet extends WalletState {
  const WalletStateNoWallet();
}

// class WalletStateFailed extends WalletState {
//   final String reason;

//   const WalletStateFailed({
//     required this.reason,
//   });
// }
