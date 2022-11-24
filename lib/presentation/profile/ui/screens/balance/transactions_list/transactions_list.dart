import 'package:flutter/widgets.dart';
import 'package:pull_point/domain/domain.dart';

import 'transaction_item.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  final transactions = [
    TransactionModel(id: 5, type: TransactionType.output, sum: 50, dateTime: DateTime(2022, 11, 24)),
    TransactionModel(id: 4, type: TransactionType.transfer, sum: 50, dateTime: DateTime(2022, 11, 23)),
    TransactionModel(id: 3, type: TransactionType.transfer, sum: 150, dateTime: DateTime(2022, 11, 22)),
    TransactionModel(id: 2, type: TransactionType.transfer, sum: 150, dateTime: DateTime(2022, 11, 21)),
    TransactionModel(id: 0, type: TransactionType.input, sum: 500, dateTime: DateTime(2022, 11, 20)),
    TransactionModel(id: 5, type: TransactionType.output, sum: 50, dateTime: DateTime(2022, 11, 24)),
    TransactionModel(id: 4, type: TransactionType.transfer, sum: 50, dateTime: DateTime(2022, 11, 23)),
    TransactionModel(id: 3, type: TransactionType.transfer, sum: 150, dateTime: DateTime(2022, 11, 22)),
    TransactionModel(id: 2, type: TransactionType.transfer, sum: 150, dateTime: DateTime(2022, 11, 21)),
    TransactionModel(id: 0, type: TransactionType.input, sum: 500, dateTime: DateTime(2022, 11, 20)),
    TransactionModel(id: 5, type: TransactionType.output, sum: 50, dateTime: DateTime(2022, 11, 24)),
    TransactionModel(id: 4, type: TransactionType.transfer, sum: 50, dateTime: DateTime(2022, 11, 23)),
    TransactionModel(id: 3, type: TransactionType.transfer, sum: 150, dateTime: DateTime(2022, 11, 22)),
    TransactionModel(id: 2, type: TransactionType.transfer, sum: 150, dateTime: DateTime(2022, 11, 21)),
    TransactionModel(id: 0, type: TransactionType.input, sum: 500, dateTime: DateTime(2022, 11, 20)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        for (final transaction in transactions) TransactionItem(transaction: transaction),
      ],
    );
  }
}
