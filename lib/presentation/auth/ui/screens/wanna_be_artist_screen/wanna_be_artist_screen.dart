import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_artist_data_screen/enter_artist_data_screen.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../home/home_page.dart';
import '../../../blocs/blocs.dart';

class WannaBeArtistScreen extends StatefulWidget {
  const WannaBeArtistScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  final UserModel user;

  @override
  State<WannaBeArtistScreen> createState() => _WannaBeArtistScreenState();
}

class _WannaBeArtistScreenState extends State<WannaBeArtistScreen> {
  bool wannaBeArtist = false;

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

  Future<void> _goToArtistRegisterScreen({
    required UserModel user,
  }) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EnterArtistDataScreen(user: user),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateAuthorized) _goToHomePage();
        if (state is AuthStateArtistCreating) _goToArtistRegisterScreen(user: state.user);
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
                    "Вы артист или зритель? Артисты могут создавать выступления и получать пожертвования.",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ),
                Column(
                  children: [
                    LongButton(
                      backgroundColor: AppColors.primary.withOpacity(0.1),
                      onTap: () {
                        context.read<AuthBloc>().add(
                              AuthEventRegisterUser(
                                id: widget.user.id,
                                email: widget.user.email,
                                username: widget.user.username ?? "-",
                                wannaBeArtist: true,
                              ),
                            );
                      },
                      child: const AppButtonText("Я артист", textColor: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    LongButton(
                      backgroundGradient: AppGradients.main,
                      onTap: () {
                        context.read<AuthBloc>().add(
                              AuthEventRegisterUser(
                                id: widget.user.id,
                                email: widget.user.email,
                                username: widget.user.username ?? "-",
                                wannaBeArtist: false,
                              ),
                            );
                        // Navigator.of(context).pop();
                      },
                      child: const AppButtonText("Я зритель", textColor: AppColors.textOnColors),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
