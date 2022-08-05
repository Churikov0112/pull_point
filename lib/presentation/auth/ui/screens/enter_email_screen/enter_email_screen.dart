import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_code_screen/enter_code_screen.dart';
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
  bool isEmpty = true;
  bool isValid = false;

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
              ),
            ),
            Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AppTextFormField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                hintText: "example@gmail.com",
                maxLines: 1,
                errorText: !isEmpty
                    ? isValid
                        ? null
                        : "Некорректный email"
                    : null,
                controller: emailEditingController,
                onEditingComplete: () {
                  setState(() {
                    isEmpty = false;
                    isValid = EmailValidator.validate(emailEditingController.text);
                    if (isValid) {
                      Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const EnterCodeScreen()));
                    }
                  });
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
