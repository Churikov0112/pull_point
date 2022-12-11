import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/blocs/blocs.dart';

import 'transaction_item.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({super.key});

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(builder: (context, walletState) {
      if (walletState is WalletStateLoaded) {
        final history = walletState.wallet?.history ?? [];
        return Column(
          children: [
            const SizedBox(height: 16),
            for (final transaction in history)
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
