import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/wanna_be_artist_screen/wanna_be_artist_screen.dart';
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
              child: AppTextFormField(
                autofocus: true,
                keyboardType: TextInputType.text,
                hintText: "username",
                maxLines: 1,
                errorText: !isEmpty ? null : "Введите username",
                controller: usernameEditingController,
                onEditingComplete: () {
                  setState(() {
                    if (usernameEditingController.text.isNotEmpty) {
                      isEmpty = false;
                    }
                    if (!isEmpty) {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => WannaBeArtistScreen(
                            userId: widget.userId,
                            username: usernameEditingController.text,
                            email: widget.email,
                          ),
                        ),
                      );
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
