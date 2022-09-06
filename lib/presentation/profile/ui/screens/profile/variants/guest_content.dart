import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../auth/blocs/auth_bloc/auth_bloc.dart';
import '../../../../../auth/ui/screens/enter_email_screen/enter_email_screen.dart';
import '../../../../../ui_kit/ui_kit.dart';

class GuestContent extends StatelessWidget {
  const GuestContent({Key? key}) : super(key: key);

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
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LongButton(
                backgroundGradient: AppGradients.main,
                child: const AppText("Авторизоваться", textColor: AppColors.textOnColors),
                onTap: () {
                  // context.read<AuthBloc>().add(const AuthEventLogout());
                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const EnterEmailScreen()));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
