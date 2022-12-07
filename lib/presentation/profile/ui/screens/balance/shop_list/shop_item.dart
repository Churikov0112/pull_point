import 'package:flutter/material.dart';
import 'package:pull_point/domain/models/models.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

class ShopItem extends StatelessWidget {
  const ShopItem({
    required this.shopItem,
    super.key,
  });

  final ShopItemModel shopItem;

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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: [
              //         AppSubtitle(shopItem.sum.toStringAsFixed(0)),
              //         const SizedBox(width: 8),
              //         Image.asset(
              //           "assets/raster/images/coin.png",
              //           height: 20,
              //           width: 20,
              //         ),
              //       ],
              //     ),
              //     const SizedBox(height: 8),
              //     AppText("Будет списано ${shopItem.costRub.toStringAsFixed(0)} руб"),
              //   ],
              // )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          AppSubtitle("Пополнить кошелёк на ${shopItem.sum}"),
                          const SizedBox(width: 8),
                          Image.asset(
                            "assets/raster/images/coin.png",
                            height: 20,
                            width: 20,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      AppText("Будет списано ${shopItem.costRub.toStringAsFixed(0)} руб"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // TouchableOpacity(
    //   onPressed: () {},
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 8),
    //     child: Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 AppSubtitle("Купить ${shopItem.sum} монет"),
    //                 const SizedBox(height: 8),
    //                 AppText("за ${shopItem.costRub} рублей"),
    //               ],
    //             ),
    //             AppSubtitle("+ ${shopItem.sum} 🪙"),
    //           ],
    //         ),
    //         const SizedBox(height: 8),
    //         const Divider(thickness: 1),
    //       ],
    //     ),
    //   ),
    // );
  }
}
