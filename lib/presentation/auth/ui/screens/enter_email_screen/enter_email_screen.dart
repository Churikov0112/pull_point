import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pull_point/presentation/home/home_page.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

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

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({Key? key}) : super(key: key);

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController emailEditingController = TextEditingController();
  bool? _isValid;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
                )),
            Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AppTextFormField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                hintText: "example@gmail.com",
                maxLines: 1,
                errorText: _isValid != null
                    ? _isValid!
                        ? null
                        : "Некорректный email"
                    : null,
                controller: emailEditingController,
                onEditingComplete: () {
                  setState(() {
                    print(EmailValidator.validate(emailEditingController.text));
                    _isValid = EmailValidator.validate(emailEditingController.text);
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            const LongButton(
              child: AppText("Отправить код", textColor: AppColors.textOnColors),
              backgroundGradient: AppGradients.main,
            ),
          ],
        ),
      ),
    );
  }
}
