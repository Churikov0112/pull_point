import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_email_screen/enter_email_screen.dart';
import 'package:pull_point/presentation/home/home_page.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../blocs/blocs.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  Future<void> _goToHomePage(BuildContext context) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> _goToEnterEmailPage(BuildContext context) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const EnterEmailScreen(cameFrom: CameFrom.start),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateAuthorized || state is AuthStateGuest) _goToHomePage(context);
          if (state is AuthStateEnterEmailPageOpened) _goToEnterEmailPage(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LongButton(
                    onTap: () {
                      context.read<AuthBloc>().add(const AuthEventOpenEmailPage());
                      // Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const EnterEmailScreen()));
                    },
                    backgroundGradient: AppGradients.main,
                    child: const AppText("Авторизоваться", textColor: AppColors.textOnColors),
                  ),
                  const SizedBox(height: 16),
                  LongButton(
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()));
                      context.read<AuthBloc>().add(const AuthEventContinueAsGuest());
                    },
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: const AppText("Продолжить как гость"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
