import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/domain.dart';
import '../../../../auth/blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: mediaQuery.size.width,
      decoration: const BoxDecoration(
        color: AppColors.backgroundPage,
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateAuthorized) {
            return Column(
              children: [
                const SizedBox(height: 100),
                UserInfoWidget(user: state.user),
                const SizedBox(height: 16),
                LongButton(
                  backgroundGradient: AppGradients.main,
                  child: const AppText("Выйти", textColor: AppColors.textOnColors),
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                  },
                ),
              ],
            );
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LongButton(
                  backgroundGradient: AppGradients.main,
                  child: const AppText("Авторизоваться", textColor: AppColors.textOnColors),
                  onTap: () {},
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTitle(user.username!),
                AppTitle("id: ${user.id}"),
              ],
            ),
            const SizedBox(height: 8),
            AppText(user.email),
          ],
        ),
      ),
    );
  }
}
