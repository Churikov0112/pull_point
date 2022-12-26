import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/blocs/blocs.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import 'transaction_item.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  void initState() {
    context.read<WalletHistoryBloc>().add(const WalletHistoryEventGet(needUpdate: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<WalletHistoryBloc, WalletHistoryState>(builder: (context, walletHistoryState) {
      if (walletHistoryState is WalletHistoryStatePending) {
        return Column(
          children: [
            SizedBox(height: mediaQuery.size.height / 4),
            const Center(child: LoadingIndicator()),
          ],
        );
      }
      if (walletHistoryState is WalletHistoryStateLoaded) {
        final history = walletHistoryState.transactions ?? [];
        return Column(
          children: [
            const SizedBox(height: 16),
            for (final transaction in history.reversed)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TransactionItem(transaction: transaction),
              ),
            const SizedBox(height: 16),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
