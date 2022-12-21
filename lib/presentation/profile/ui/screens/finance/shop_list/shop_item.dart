import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/models/models.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../../blocs/blocs.dart';

class ShopItem extends StatefulWidget {
  const ShopItem({
    required this.shopItem,
    super.key,
  });

  final ShopItemModel shopItem;

  @override
  State<ShopItem> createState() => _ShopItemState();
}

class _ShopItemState extends State<ShopItem> {
  showEnsureTransactionDialog(BuildContext context, ShopItemModel shopItem, WalletModel wallet) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Покупка вутренней валюты"),
          content: Text(
              "Вы действительно хотите купить ${shopItem.sum} внутренней валюты? С вашей карты **** ${wallet.cardNumber.substring(wallet.cardNumber.length - 4)} будет списано ${shopItem.costRub} руб."),
          actions: [
            TextButton(
              child: const Text("Нет"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Да",
                style: TextStyle(color: AppColors.error),
              ),
              onPressed: () {
                context.read<WalletAddingMoneyBloc>().add(WalletAddingMoneyEventAddMoney(shopItem: shopItem));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WalletAddingMoneyBloc, WalletAddingMoneyState>(
      listener: (context, walletAddingMoneyListenerState) {
        if (walletAddingMoneyListenerState is WalletAddingMoneyStateReady) {
          context.read<WalletBloc>().add(const WalletEventGet(needUpdate: true));
        }
      },
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, walletState) {
          return TouchableOpacity(
            onPressed: () {
              if (walletState is WalletStateLoaded) {
                if (walletState.wallet != null) {
                  showEnsureTransactionDialog(context, widget.shopItem, walletState.wallet!);
                }
              }
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.backgroundPage,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AppSubtitle("Пополнить кошелёк на ${widget.shopItem.sum}"),
                                const SizedBox(width: 8),
                                Image.asset(
                                  "assets/raster/images/coin.png",
                                  height: 20,
                                  width: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            AppText("Будет списано ${widget.shopItem.costRub.toStringAsFixed(0)} руб"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
