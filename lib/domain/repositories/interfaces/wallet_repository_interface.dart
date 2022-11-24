import '../../models/models.dart';

abstract class WalletRepositoryInterface {
  Future<WalletModel?> getUserWallet({
    required bool needUpdate,
  });

  Future<WalletModel?> createUserWallet();
}
