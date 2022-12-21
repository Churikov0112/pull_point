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
    String transferText;
    if (transaction.dir == TransactionDir.income) {
      transferText = 'Получено пожертвование';
    } else {
      transferText = 'Вы пожертвовали';
    }

    return transaction.type == TransactionType.input
        ? "Пополнение"
        : transaction.type == TransactionType.output
            ? "Вывод средств"
            : transferText;
  }

  String getTransactionSumText() {
    return (transaction.type == TransactionType.input || transaction.dir == TransactionDir.income)
        ? "+ ${transaction.sum.toStringAsFixed(0)}"
        : "- ${transaction.sum.toStringAsFixed(0)}";
  }

  Color getTransactionSumColor() {
    if (transaction.type == TransactionType.input || transaction.dir == TransactionDir.income) return AppColors.success;
    return AppColors.text;
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
          color: AppColors.backgroundPage,
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppSubtitle(
                    getTransactionSumText(),
                    textColor: getTransactionSumColor(),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    "assets/raster/images/coin.png",
                    height: 20,
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
