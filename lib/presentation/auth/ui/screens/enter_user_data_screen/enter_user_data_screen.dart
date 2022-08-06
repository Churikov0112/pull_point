import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';
import '../../../blocs/blocs.dart';

class EnterUserDataScreen extends StatefulWidget {
  const EnterUserDataScreen({
    required this.userId,
    required this.email,
    Key? key,
  }) : super(key: key);

  final int userId;
  final String email;

  @override
  State<EnterUserDataScreen> createState() => _EnterUserDataScreenState();
}

class _EnterUserDataScreenState extends State<EnterUserDataScreen> {
  final TextEditingController usernameEditingController = TextEditingController();
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
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
                "Как вас величать?",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
            Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AppTextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                hintText: "username",
                maxLines: 1,
                errorText: !isEmpty
                    // ? isValid
                    ? null
                    : "Введите username",
                // : null,
                controller: usernameEditingController,
                onEditingComplete: () {
                  setState(() {
                    if (usernameEditingController.text.isNotEmpty) {
                      isEmpty = false;
                    }
                    if (!isEmpty) {
                      // Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()));
                      context
                          .read<AuthBloc>()
                          .add(AuthEventRegister(id: widget.userId, email: widget.email, username: usernameEditingController.text));
                    }
                    FocusScope.of(context).unfocus();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
