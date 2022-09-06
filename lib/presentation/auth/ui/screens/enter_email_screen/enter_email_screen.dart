import 'package:bot_toast/bot_toast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_code_screen/enter_code_screen.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../home/home_page.dart';
import '../../../blocs/blocs.dart';
import '../start/start_screen.dart';

String? validateEmail(String? value) {
  String pattern = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = RegExp(pattern);
  if (value == null || value.isEmpty || !regex.hasMatch(value)) {
    return 'Enter a valid email address';
  } else {
    return null;
  }
}

enum CameFrom { start, guest }

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({
    required this.cameFrom,
    Key? key,
  }) : super(key: key);

  final CameFrom cameFrom;

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController emailEditingController = TextEditingController();
  bool isEmpty = true;
  bool isValid = false;

  Future<bool> _onWillPop() async {
    if (widget.cameFrom == CameFrom.start) context.read<AuthBloc>().add(const AuthEventLogout());
    if (widget.cameFrom == CameFrom.guest) {
      context.read<AuthBloc>().add(const AuthEventContinueAsGuest());
    }

    return false;
  }

  Future<void> _goToEnterCodeScreen() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => EnterCodeScreen(email: emailEditingController.text, cameFrom: widget.cameFrom)),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> _goToStartScreen() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => const StartScreen()),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> _goToHomePage() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateCodeSent) _goToEnterCodeScreen();
          if (state is AuthStateUnauthorized) _goToStartScreen();
          if (state is AuthStateGuest) _goToHomePage();
          return Scaffold(
            backgroundColor: AppColors.backgroundPage,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const GradientText(
                    gradient: AppGradients.main,
                    src: Text(
                      "Введите ваш Email",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Form(
                    child: AppTextFormField(
                      keyboardType: TextInputType.emailAddress,
                      hintText: "example@gmail.com",
                      maxLines: 1,
                      controller: emailEditingController,
                    ),
                  ),
                  LongButton(
                    backgroundGradient: AppGradients.main,
                    onTap: () {
                      isValid = EmailValidator.validate(emailEditingController.text);
                      if (!isValid) {
                        BotToast.showText(text: "Введите корректный Email");
                        return;
                      }
                      context.read<AuthBloc>().add(AuthEventSendCode(email: emailEditingController.text));
                    },
                    child: const AppButtonText("Отправить код", textColor: AppColors.textOnColors),
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
