import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_email_screen/enter_email_screen.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_user_data_screen/enter_user_data_screen.dart';
import 'package:pull_point/presentation/home/home_page.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../../domain/models/user/user.dart';
import '../../../blocs/blocs.dart';
import '../wanna_be_artist_screen/wanna_be_artist_screen.dart';

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({
    required this.email,
    Key? key,
  }) : super(key: key);

  final String email;

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController codeEditingController = TextEditingController();

  Future<void> _goToHomePage() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> _goToUserRegisterScreen({
    required UserModel user,
  }) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EnterUserDataScreen(user: user),
        ),
      );
    });
  }

  Future<void> _goToEnterEmailScreen() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const EnterEmailScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateAuthorized) _goToHomePage();
        if (state is AuthStateCodeVerified) _goToUserRegisterScreen(user: state.user);
        if (state is AuthStateEnterEmailPageOpened) _goToEnterEmailScreen();
        return Scaffold(
          backgroundColor: AppColors.backgroundPage,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: mediaQuery.size.width - 32,
                  child: GradientText(
                    gradient: AppGradients.main,
                    src: Text(
                      "Введите код, который мы прислали на ${widget.email}",
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Form(
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: AppTextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "******",
                    inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    maxLines: 1,
                    // errorText: (codeEditingController.text == "qwerty" || codeEditingController.text.isEmpty)
                    //     ? null
                    //     : "Код неверный",
                    controller: codeEditingController,
                    onEditingComplete: () async {
                      context
                          .read<AuthBloc>()
                          .add(AuthEventLogin(email: widget.email, code: codeEditingController.text));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
