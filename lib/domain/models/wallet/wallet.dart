part of '../models.dart';

class WalletModel {
  final int balance;
  final String cardNumber;

  const WalletModel({
    required this.balance,
    required this.cardNumber,
  });

  static WalletModel fromJson(dynamic source) {
    return WalletModel(
      balance: source['balance'],
      cardNumber: source['bankCredentials'],
    );
  }
}
