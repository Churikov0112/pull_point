import 'package:bot_toast/bot_toast.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';

part 'create_wallet_event.dart';
part 'create_wallet_state.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState> {
  CreateWalletBloc({
    required WalletRepositoryInterface walletRepository,
  })  : _walletRepository = walletRepository,
        super(const CreateWalletStateInitial()) {
    on<CreateWalletEventCreate>(_createWallet);
  }

  final WalletRepositoryInterface _walletRepository;

  Future<void> _createWallet(CreateWalletEventCreate event, Emitter<CreateWalletState> emit) async {
    emit(const CreateWalletStateInitial());
    final wallet = await _walletRepository.createUserWallet(cardNumber: event.cardNumber);
    if (wallet != null) {
      emit(CreateWalletStateCreated(wallet: wallet));
    } else {
      BotToast.showText(text: "Не удалось создать кошелек");
    }
  }
}
