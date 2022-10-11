import 'package:flutter/widgets.dart';

import '../../../../../../domain/models/user/user.dart';
import '../../../../../ui_kit/ui_kit.dart';

class BalanceInfoWidget extends StatelessWidget {
  const BalanceInfoWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return TouchableOpacity(
      onPressed: () {},
      child: Container(
        width: mediaQuery.size.width,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              AppTitle("Баланс"),
              AppTitle("100 🪙"),
            ],
          ),
        ),
      ),
    );
  }
}
