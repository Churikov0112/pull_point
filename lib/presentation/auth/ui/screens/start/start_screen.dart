import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_email_screen/enter_email_screen.dart';
import 'package:pull_point/presentation/home/home_page.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LongButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const EnterEmailScreen()));
              },
              backgroundGradient: AppGradients.main,
              child: AppText("Авторизоваться", textColor: AppColors.textOnColors),
            ),
            const SizedBox(height: 16),
            LongButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()));
              },
              backgroundColor: AppColors.primary.withOpacity(0.1),
              child: const AppText("Войти как гость"),
            ),
          ],
        ),
      ),
    );
  }
}
