part of '../models.dart';

class WalletModel {
  final int id;
  final int balance;
  final String cardNumber;
  final List<TransactionModel> history;

  const WalletModel({
    required this.id,
    required this.balance,
    required this.history,
    required this.cardNumber,
  });

  static WalletModel fromJson(dynamic source) {
    return WalletModel(
      id: source['id'],
      balance: source['balance'],
      cardNumber: source['bankCredentials'],
      history: [
        for (final transaction in source['history']) TransactionModel.fromJson(transaction),
      ],
    );
  }
}
