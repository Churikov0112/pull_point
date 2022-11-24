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
                    AppSubtitle("Купить ${shopItem.sum} монет"),
                    const SizedBox(height: 8),
                    AppText("за ${shopItem.costRub} рублей"),
                  ],
                ),
                AppSubtitle("+ ${shopItem.sum} 🪙"),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
