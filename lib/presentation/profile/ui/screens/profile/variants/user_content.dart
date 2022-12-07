import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/blocs.dart';
import '../../../../../ui_kit/ui_kit.dart';
import '../widgets/widgets.dart';

class UserContent extends StatefulWidget {
  const UserContent({
    Key? key,
  }) : super(key: key);

  @override
  State<UserContent> createState() => _UserContentState();
}

class _UserContentState extends State<UserContent> {
  @override
  void initState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthStateAuthorized) {
      if (authState.user.isArtist == true) {
        context.read<UserArtistsBloc>().add(UserArtistsEventLoad(userId: authState.user.id));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: mediaQuery.size.width,
      decoration: const BoxDecoration(color: AppColors.backgroundPage),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateAuthorized) {
            return Column(
              children: [
                const SizedBox(height: 50),
                UserInfoWidget(user: state.user),
                const SizedBox(height: 16),
                BalanceInfoWidget(user: state.user),
                const SizedBox(height: 16),
                BlocBuilder<UserArtistsBloc, UserArtistsState>(
                  builder: (context, state) {
                    if (state is UserArtistsStateLoading) return const LoadingIndicator();
                    if (state is UserArtistsStateSelected) return const ArtistInfoWidget();
                    return const SizedBox.shrink();
                  },
                ),
                // const ArtistInfoWidget(),
                const Spacer(),
                LongButton(
                  backgroundColor: AppColors.orange,
                  child: const AppText("Выйти", textColor: AppColors.textOnColors),
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthEventLogout());
                  },
                ),
                const SizedBox(height: 16),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
