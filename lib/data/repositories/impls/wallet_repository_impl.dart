import 'dart:convert';

import 'package:pull_point/domain/repositories/interfaces/wallet_repository_interface.dart';
import '../../../domain/models/models.dart';
import '../../../main.dart' as main;
import '../../http_requests/http_requests.dart';

class WalletRepositoryImpl implements WalletRepositoryInterface {
  WalletRepositoryImpl();

  @override
  Future<WalletModel?> getUserWallet() async {
    final response = await GetUserWalletRequest.send(
      jwt: main.userBox.get("user")?.accessToken,
    );

    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      return WalletModel.fromJson(decodedResponse);
    }
    return null;
  }

  @override
  Future<WalletModel?> createUserWallet({
    required String cardNumber,
  }) async {
    final response = await CreateUserWalletRequest.send(
      cardNumber: cardNumber,
      jwt: main.userBox.get("user")?.accessToken,
    );

    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      return WalletModel.fromJson(decodedResponse);
    }

    return null;
  }

  @override
  Future<bool> buyCoins({required int sum}) async {
    final response = await FinanceInputRequest.send(
      sum: sum,
      jwt: main.userBox.get("user")?.accessToken,
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> sellCoins({
    required int sum,
  }) async {
    final response = await FinanceOutputRequest.send(
      sum: sum,
      jwt: main.userBox.get("user")?.accessToken,
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> transferCoins({
    required String artistName,
    required int sum,
  }) async {
    final response = await FinanceTransferRequest.send(
      sum: sum,
      jwt: main.userBox.get("user")?.accessToken,
      targetArtistName: artistName,
    );

    return response.statusCode == 200;
  }

  // @override
  // Future<WalletModel?> updateUserWallet({
  //   required String cardNumber,
  //   required String cardExpireDate,
  //   required String cardCVV,
  // }) async {
  //   // TODO: implement updateUserWallet
  //   throw UnimplementedError();
  // }
}
