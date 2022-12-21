part of '../models.dart';

enum TransactionType {
  input,
  transfer,
  output,
  other,
}

enum TransactionDir {
  income,
  outcome,
  other,
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
      return TransactionType.other;
  }
}

TransactionDir? _transactionDirFromString(String type, String? dir) {
  if (type == "TRANSFER") {
    switch (dir) {
      case "IN":
        return TransactionDir.income;
      case "OUT":
        return TransactionDir.outcome;
      default:
        return TransactionDir.other;
    }
  } else {
    return null;
  }
}

class TransactionModel {
  final int id;
  final TransactionType type;
  final TransactionDir? dir;
  final int sum;
  final DateTime dateTime;

  const TransactionModel({
    required this.id,
    required this.type,
    required this.dir,
    required this.sum,
    required this.dateTime,
  });

  static TransactionModel fromJson(dynamic source) {
    return TransactionModel(
      id: source['id'],
      type: _transactionTypeFromString(source["type"]),
      dir: _transactionDirFromString(source["type"], source["dir"]),
      sum: source['sum'],
      dateTime: DateTime.parse(source['timestamp']).add(const Duration(hours: 3)),
    );
  }
}
