import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../blocs/blocs.dart';

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
                  context.read<AuthBloc>().add(AuthEventLogin(email: widget.email, code: codeEditingController.text));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
