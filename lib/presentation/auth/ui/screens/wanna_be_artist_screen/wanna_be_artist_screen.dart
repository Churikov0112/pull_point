import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';
import '../../../blocs/blocs.dart';

class WannaBeArtistScreen extends StatefulWidget {
  const WannaBeArtistScreen({
    required this.userId,
    required this.email,
    required this.username,
    Key? key,
  }) : super(key: key);

  final int userId;
  final String email;
  final String username;

  @override
  State<WannaBeArtistScreen> createState() => _WannaBeArtistScreenState();
}

class _WannaBeArtistScreenState extends State<WannaBeArtistScreen> {
  bool wannaBeArtist = false;

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
                "Вы артист или зритель? Артисты могут создавать выступления и получать пожертвовани. Можно поменять в настройках",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
            ),
            Column(
              children: [
                LongButton(
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  onTap: () {
                    context.read<AuthBloc>().add(
                          AuthEventRegister(
                            id: widget.userId,
                            email: widget.email,
                            username: widget.username,
                            wannaBeArtist: true,
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                  child: const AppButtonText("Я артист", textColor: AppColors.primary),
                ),
                const SizedBox(height: 16),
                LongButton(
                  backgroundGradient: AppGradients.main,
                  onTap: () {
                    context.read<AuthBloc>().add(
                          AuthEventRegister(
                            id: widget.userId,
                            email: widget.email,
                            username: widget.username,
                            wannaBeArtist: false,
                          ),
                        );
                    Navigator.of(context).pop();
                  },
                  child: const AppButtonText("Я зритель", textColor: AppColors.textOnColors),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
