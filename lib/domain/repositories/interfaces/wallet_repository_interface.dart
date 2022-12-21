import '../../models/models.dart';

abstract class WalletRepositoryInterface {
  /// Создание внутреннего кошелька, в котором позже будет внутренняя валюта
  Future<WalletModel?> createUserWallet({required String cardNumber});

  /// Получение внутреннего кошелька
  Future<WalletModel?> getUserWallet();

  /// Покупка внутренней валюты, пополнение кошелька
  Future<bool> buyCoins({required int sum});

  /// Продажа внутренней валюты, вывод денег на карту
  Future<bool> sellCoins({required int sum});

  /// Перевод внутренней валюты другому артисту
  Future<bool> transferCoins({required String artistName, required int sum});

  // /// Изменение внутреннего кошелька
  // Future<WalletModel?> updateUserWallet({
  //   required String cardNumber,
  //   required String cardExpireDate,
  //   required String cardCVV,
  // });

}
