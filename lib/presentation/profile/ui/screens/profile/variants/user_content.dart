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
  late AuthBloc authBloc;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    final authState = authBloc.state;
    if (authState is AuthStateAuthorized) {
      if (authState.user.isArtist == true) {
        refreshData(userId: authState.user.id);
      }
    }
    super.initState();
  }

  void refreshData({required int userId}) {
    context.read<UserArtistsBloc>().add(UserArtistsEventLoad(userId: userId));
    context.read<WalletBloc>().add(const WalletEventGet(needUpdate: true));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return RefreshIndicator(
      displacement: 100,
      color: AppColors.orange,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 300));
        final authState = authBloc.state;
        if (authState is AuthStateAuthorized) {
          if (authState.user.isArtist == true) {
            refreshData(userId: authState.user.id);
          }
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: mediaQuery.size.height,
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
                    const BalanceInfoWidget(),
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
                      onTap: () async {
                        context.read<UserArtistsBloc>().add(const UserArtistsEventResetSelectOnLogout());
                        context.read<FeedFiltersBloc>().add(const ResetFeedFiltersEvent());

                        context.read<AuthBloc>().add(const AuthEventLogout());
                      },
                    ),
                    const SizedBox(height: 72),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
