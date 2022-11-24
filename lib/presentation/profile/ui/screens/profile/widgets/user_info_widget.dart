import 'package:flutter/widgets.dart';

import '../../../../../../domain/models/user/user.dart';
import '../../../../../ui_kit/ui_kit.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
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
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText("Пользователь"),
              // AppText("id: ${user.id}"),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTitle(user.username ?? "NO USERNAME"),
                ],
              ),
              const SizedBox(height: 8),
              AppText(user.email),
            ],
          ),
        ),
      ),
    );
  }
}
