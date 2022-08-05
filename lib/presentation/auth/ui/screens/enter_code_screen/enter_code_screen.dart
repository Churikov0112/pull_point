import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class EnterCodeScreen extends StatefulWidget {
  const EnterCodeScreen({Key? key}) : super(key: key);

  @override
  State<EnterCodeScreen> createState() => _EnterCodeScreenState();
}

class _EnterCodeScreenState extends State<EnterCodeScreen> {
  final TextEditingController codeEditingController = TextEditingController();

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
            SizedBox(
              width: mediaQuery.size.width - 32,
              child: const GradientText(
                  gradient: AppGradients.main,
                  src: Text(
                    "Введите код, который мы прислали на ваш Email",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  )),
            ),
            Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AppTextFormField(
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                hintText: "******",
                inputFormatters: [LengthLimitingTextInputFormatter(6)],
                maxLines: 1,
                errorText: (codeEditingController.text == "qwerty" || codeEditingController.text.isEmpty) ? null : "Код неверный",
                controller: codeEditingController,
                onEditingComplete: () {
                  if (codeEditingController.text == 'qwerty') {
                    Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()));
                  } else {
                    setState(() {});
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
