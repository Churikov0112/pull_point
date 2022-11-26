import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_point/domain/models/models.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    required this.transaction,
    super.key,
  });

  final TransactionModel transaction;

  String getTransactionTitle() {
    return transaction.type == TransactionType.input
        ? "Пополнение"
        : transaction.type == TransactionType.output
            ? "Вывод средств"
            : "Перевод";
  }

  String getTransactionDateTime() {
    return DateFormat("dd.MM.yyyy HH:mm").format(transaction.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSubtitle(getTransactionTitle()),
                  const SizedBox(height: 8),
                  AppText(getTransactionDateTime()),
                ],
              ),
              AppSubtitle(
                transaction.type == TransactionType.input
                    ? "+ ${transaction.sum.toStringAsFixed(0)} 🪙"
                    : transaction.type == TransactionType.output
                        ? "- ${transaction.sum.toStringAsFixed(0)} 🪙"
                        : "- ${transaction.sum.toStringAsFixed(0)} 🪙",
                textColor: transaction.type == TransactionType.input
                    ? AppColors.success
                    : transaction.type == TransactionType.output
                        ? AppColors.error
                        : AppColors.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
