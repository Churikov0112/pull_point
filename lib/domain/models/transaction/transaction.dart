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
      type: source['type'],
      sum: source['sum'],
      dateTime: DateTime.parse(source['dateTime']),
    );
  }
}
