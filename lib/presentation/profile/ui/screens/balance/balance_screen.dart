import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_point/presentation/profile/ui/screens/balance/transactions_list/transactions_list.dart';

import '../../../../ui_kit/ui_kit.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  int _groupSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: mediaQuery.size.width,
        decoration: const BoxDecoration(color: AppColors.backgroundPage),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.padding.top + 24),
              PullPointAppBar(
                title: "Баланс",
                onBackPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: mediaQuery.size.width,
                child: CupertinoSlidingSegmentedControl(
                  groupValue: _groupSliderValue,
                  children: const {
                    0: AppSubtitle("История"),
                    1: AppSubtitle("Пополнить"),
                    2: AppSubtitle("Вывести"),
                  },
                  onValueChanged: (newValue) {
                    setState(() => _groupSliderValue = int.parse(newValue.toString()));
                  },
                ),
              ),
              if (_groupSliderValue == 0) const TransactionsList(),
            ],
          ),
        ),
      ),
    );
  }
}
