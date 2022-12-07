import 'package:flutter/widgets.dart';
import 'package:pull_point/domain/domain.dart';

import 'shop_item.dart';

class ShopItemsList extends StatefulWidget {
  const ShopItemsList({super.key});

  @override
  State<ShopItemsList> createState() => _ShopItemsListState();
}

class _ShopItemsListState extends State<ShopItemsList> {
  final shopItems = const [
    ShopItemModel(id: 0, sum: 100, costRub: 110),
    ShopItemModel(id: 1, sum: 200, costRub: 220),
    ShopItemModel(id: 2, sum: 300, costRub: 330),
    ShopItemModel(id: 3, sum: 500, costRub: 540),
    ShopItemModel(id: 4, sum: 1000, costRub: 1050),
  ];

  @override
  Widget build(BuildContext context) {
    final meduaQuery = MediaQuery.of(context);
    return SizedBox(
      height: meduaQuery.size.height,
      child: Column(
        children: [
          const SizedBox(height: 8),
          for (int i = 0; i < shopItems.length; i++)
            // for (final shopItem in shopItems)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ShopItem(shopItem: shopItems[i]),
            ),
          const Spacer(),
        ],
      ),
    );
  }
}
