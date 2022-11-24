part of '../models.dart';

class WalletModel {
  final int id;
  final double balance;
  final List<TransactionModel> history;

  const WalletModel({
    required this.id,
    required this.balance,
    required this.history,
  });

  static WalletModel fromJson(dynamic source) {
    return WalletModel(
      id: source['id'],
      balance: source['balance'],
      history: [
        for (final transaction in source['history']) TransactionModel.fromJson(transaction),
      ],
    );
  }
}
