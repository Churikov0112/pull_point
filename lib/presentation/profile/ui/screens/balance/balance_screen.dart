import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/profile/ui/screens/balance/transactions_list/transactions_list.dart';
import 'package:pull_point/presentation/profile/ui/screens/balance/withdraw_money_section/withdraw_money_section.dart';

import '../../../../blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';
import 'shop_list/shop_list.dart';

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
        decoration: const BoxDecoration(color: AppColors.backgroundCard),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.padding.top + 24),
              PullPointAppBar(
                title: "Менеджер финансов",
                onBackPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: mediaQuery.size.width,
                child: CupertinoSlidingSegmentedControl(
                  thumbColor: AppColors.backgroundCard,
                  backgroundColor: AppColors.backgroundPage,
                  groupValue: _groupSliderValue,
                  children: const {
                    0: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: AppSubtitle("История"),
                    ),
                    1: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: AppSubtitle("Пополнить"),
                    ),
                    2: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: AppSubtitle("Вывести"),
                    ),
                  },
                  onValueChanged: (newValue) {
                    setState(() => _groupSliderValue = int.parse(newValue.toString()));
                  },
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, walletState) {
                  if (walletState is WalletStatePending) {
                    return const Center(
                      child: LinearProgressIndicator(
                        color: AppColors.orange,
                        backgroundColor: AppColors.surface,
                      ),
                    );
                  }

                  if (walletState is WalletStateLoaded) {
                    if (walletState.wallet != null) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              AppTitle("Текущий баланс: ${walletState.wallet!.balance}"),
                              const SizedBox(width: 8),
                              Image.asset(
                                "assets/raster/images/coin.png",
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (_groupSliderValue == 0) const TransactionsList(),
                          if (_groupSliderValue == 1) const ShopItemsList(),
                          if (_groupSliderValue == 2) const WithdrawMoneySection(),
                        ],
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
