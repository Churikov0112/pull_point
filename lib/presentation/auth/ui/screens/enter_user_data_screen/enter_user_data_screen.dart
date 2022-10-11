import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/wanna_be_artist_screen/wanna_be_artist_screen.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../../domain/models/user/user.dart';
import '../../../../blocs/blocs.dart';

class EnterUserDataScreen extends StatefulWidget {
  const EnterUserDataScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  final UserModel user;

  @override
  State<EnterUserDataScreen> createState() => _EnterUserDataScreenState();
}

class _EnterUserDataScreenState extends State<EnterUserDataScreen> {
  final TextEditingController usernameEditingController = TextEditingController();

  Future<void> _goToWannaBeArtistScreen({
    required UserModel user,
  }) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (BuildContext context) => WannaBeArtistScreen(user: user)),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateUsernameInputed) _goToWannaBeArtistScreen(user: state.user);

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
                  AppTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: "username",
                    maxLines: 1,
                    controller: usernameEditingController,
                  ),
                  LongButton(
                    backgroundGradient: AppGradients.main,
                    onTap: () {
                      if (usernameEditingController.text.isEmpty) {
                        BotToast.showText(text: "Введите имя пользователя");
                        return;
                      }

                      context.read<AuthBloc>().add(
                            AuthEventOpenWannaBeArtistPage(
                              user: UserModel(
                                id: widget.user.id,
                                username: usernameEditingController.text,
                                accessToken: widget.user.accessToken,
                                email: widget.user.email,
                                isArtist: false, // потом это может измениться
                              ),
                            ),
                          );
                    },
                    child: const AppButtonText("Создать", textColor: AppColors.textOnColors),
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
