part of '../models.dart';

enum TransactionType {
  input,
  transfer,
  output,
}

TransactionType _transactionTypeFromString(String type) {
  switch (type) {
    case "INPUT":
      return TransactionType.input;
    case "TRANSFER":
      return TransactionType.transfer;
    case "OUTPUT":
      return TransactionType.output;
    default:
      return TransactionType.transfer;
  }
}

class TransactionModel {
  final int id;
  final TransactionType type;
  final int sum;
  final DateTime dateTime;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.sum,
    required this.dateTime,
  });

  static TransactionModel fromJson(dynamic source) {
    return TransactionModel(
      id: source['id'],
      type: _transactionTypeFromString(source["type"]),
      sum: source['sum'],
      dateTime: DateTime.parse(source['timestamp']).add(const Duration(hours: 3)),
    );
  }
}
