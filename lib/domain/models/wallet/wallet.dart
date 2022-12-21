part of '../models.dart';

class WalletModel {
  final int id;
  final int balance;
  final String cardNumber;

  const WalletModel({
    required this.id,
    required this.balance,
    required this.cardNumber,
  });

  static WalletModel fromJson(dynamic source) {
    return WalletModel(
      id: source['id'],
      balance: source['balance'],
      cardNumber: source['bankCredentials'],
    );
  }
}
