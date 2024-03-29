import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/enter_artist_data_screen/enter_artist_data_screen.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';
import '../../../../../domain/models/user/user.dart';
import '../../../../blocs/blocs.dart';
import '../../../../home/home_page.dart';

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthorized) _goToHomePage();
        if (state is AuthStateArtistCreating) _goToArtistRegisterScreen(user: state.user);
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: AppColors.backgroundCard,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const GradientText(
                  gradient: AppGradients.main,
                  src: Text(
                    "Вы артист или зритель? Артисты могут создавать выступления и получать пожертвования.",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, authState) {
                        if (authState is AuthStatePending) {
                          return const LongButton(
                            backgroundColor: AppColors.orange,
                            isDisabled: true,
                            child: LoadingIndicator(),
                          );
                        }
                        return LongButton(
                          backgroundColor: AppColors.blue,
                          onTap: () {
                            context.read<AuthBloc>().add(AuthEventRegisterUser(user: widget.user));
                          },
                          child: const AppButtonText("Я зритель", textColor: AppColors.textOnColors),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    LongButton(
                      backgroundColor: AppColors.orange,
                      onTap: () {
                        context.read<AuthBloc>().add(AuthEventOpenUpdateArtistPage(user: widget.user));
                      },
                      child: const AppButtonText("Я артист", textColor: AppColors.textOnColors),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
