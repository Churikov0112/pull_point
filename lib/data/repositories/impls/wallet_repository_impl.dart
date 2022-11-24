import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pull_point/domain/repositories/interfaces/wallet_repository_interface.dart';
import '../../../domain/models/models.dart';
import '../../http_requests/http_requests.dart';

class WalletRepositoryImpl implements WalletRepositoryInterface {
  Box<UserModel?> userBox;

  WalletRepositoryImpl({
    required this.userBox,
  });

  WalletModel? userWallet;

  @override
  Future<WalletModel?> getUserWallet({
    required bool needUpdate,
  }) async {
    if (needUpdate) {
      final response = await GetUserWalletRequest.send(
        jwt: userBox.get("user")?.accessToken,
      );

      if (response.statusCode == 200) {
        String source = const Utf8Decoder().convert(response.bodyBytes);
        final decodedResponse = jsonDecode(source);
        userWallet = WalletModel.fromJson(decodedResponse);
      }
    }
    return userWallet;
  }

  @override
  Future<WalletModel?> createUserWallet() async {
    final response = await CreateUserWalletRequest.send(
      jwt: userBox.get("user")?.accessToken,
    );

    if (response.statusCode == 200) {
      String source = const Utf8Decoder().convert(response.bodyBytes);
      final decodedResponse = jsonDecode(source);
      userWallet = WalletModel.fromJson(decodedResponse);
    }

    return userWallet;
  }
}
