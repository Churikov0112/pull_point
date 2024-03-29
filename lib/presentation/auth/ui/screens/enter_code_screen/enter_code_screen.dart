import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_user_data_screen/enter_user_data_screen.dart';
import 'package:pull_point/presentation/home/home_page.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../../domain/models/user/user.dart';
import '../../../../blocs/blocs.dart';
import '../enter_email_screen/enter_email_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({
    required this.email,
    required this.cameFrom,
    Key? key,
  }) : super(key: key);

  final String email;
  final CameFrom cameFrom;

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController codeEditingController = TextEditingController();

  Future<void> _goToHomePage() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> _goToUserRegisterScreen({
    required UserModel user,
  }) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => EnterUserDataScreen(user: user)),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> _goToEnterEmailScreen() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => EnterEmailScreen(cameFrom: widget.cameFrom)),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<bool> _onWillPop() async {
    context.read<AuthBloc>().add(const AuthEventOpenEmailPage());
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, authListenerState) {
          if (authListenerState is AuthStateAuthorized) _goToHomePage();
          if (authListenerState is AuthStateEnterEmailPageOpened) _goToEnterEmailScreen();
          if (authListenerState is AuthStateCodeVerified) _goToUserRegisterScreen(user: authListenerState.user);
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundCard,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: mediaQuery.size.width - 32,
                  child: GradientText(
                    gradient: AppGradients.main,
                    src: Text(
                      "Введите код, который мы прислали на ${widget.email})",
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState is AuthStateCodeSent) {
                      return SizedBox(
                        width: mediaQuery.size.width - 32,
                        child: GradientText(
                          gradient: AppGradients.main,
                          src: Text(
                            "Код: ${authState.code}",
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 16),
                Form(
                  child: AppTextFormField(
                    keyboardType: TextInputType.number,
                    hintText: "******",
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    maxLines: 1,
                    controller: codeEditingController,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState is AuthStatePending) {
                      return const LongButton(
                        backgroundColor: AppColors.orange,
                        isDisabled: true,
                        child: LoadingIndicator(),
                      );
                    }
                    return LongButton(
                      backgroundColor: AppColors.orange,
                      onTap: () {
                        if (codeEditingController.text.isEmpty) {
                          BotToast.showText(text: "Вы не ввели код");
                          return;
                        }
                        FocusScope.of(context).unfocus();
                        context
                            .read<AuthBloc>()
                            .add(AuthEventLogin(email: widget.email, code: codeEditingController.text));
                      },
                      child: const AppButtonText("Далее", textColor: AppColors.textOnColors),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
