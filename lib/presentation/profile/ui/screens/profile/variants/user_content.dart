import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/blocs/auth_bloc/auth_bloc.dart';
import '../../../../../ui_kit/ui_kit.dart';
import '../widgets/widgets.dart';

class UserContent extends StatelessWidget {
  const UserContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: mediaQuery.size.width,
      decoration: const BoxDecoration(color: AppColors.backgroundPage),
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
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
