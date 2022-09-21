import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_email_screen/enter_email_screen.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../ui_kit/ui_kit.dart';

class GuestContent extends StatelessWidget {
  const GuestContent({Key? key}) : super(key: key);

  Future<void> _goToEnterEmailPage(BuildContext context) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => const EnterEmailScreen(cameFrom: CameFrom.guest)),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateEnterEmailPageOpened) _goToEnterEmailPage(context);
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: mediaQuery.size.width,
          decoration: const BoxDecoration(color: AppColors.backgroundPage),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: LongButton(
                    backgroundGradient: AppGradients.main,
                    child: const AppText("Авторизоваться", textColor: AppColors.textOnColors),
                    onTap: () {
                      context.read<AuthBloc>().add(const AuthEventOpenEmailPage());
                      // Navigator.of(context)
                      //     .push(MaterialPageRoute<void>(builder: (BuildContext context) => const EnterEmailScreen(cameFrom: CameFrom.guest)));
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
