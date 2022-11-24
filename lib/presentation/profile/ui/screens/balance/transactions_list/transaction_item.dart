import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pull_point/domain/models/models.dart';
import 'package:pull_point/presentation/ui_kit/colors/app_colors.dart';
import 'package:pull_point/presentation/ui_kit/text/main_text.dart';
import 'package:pull_point/presentation/ui_kit/text/subtitle.dart';
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
    final mediaQuery = MediaQuery.of(context);
    return TouchableOpacity(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Row(
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
            const SizedBox(height: 8),
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
    ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(getTransactionTitle()),
      subtitle: Text(getTransactionDateTime()),
      trailing: AppSubtitle(
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
    );
  }
}
