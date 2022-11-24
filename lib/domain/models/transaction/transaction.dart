part of '../models.dart';

enum TransactionType {
  input,
  transfer,
  output,
}

class TransactionModel {
  final int id;
  final TransactionType type;
  final double sum;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.sum,
  });

  static TransactionModel fromJson(dynamic source) {
    return TransactionModel(
      id: source['id'],
      type: source['type'],
      sum: source['sum'],
    );
  }
}
