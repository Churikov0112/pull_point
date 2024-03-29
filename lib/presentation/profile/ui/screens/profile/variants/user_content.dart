import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/main.dart';
import 'package:pull_point/presentation/profile/ui/screens/profile/widgets/artist_qr_widget.dart';

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
      refreshData(userId: authState.user.id);
    }
    super.initState();
  }

  void refreshData({required int userId}) {
    context.read<WalletBloc>().add(const WalletEventGet(needUpdate: true));

    final authState = authBloc.state;
    if (authState is AuthStateAuthorized) {
      if (authState.user.isArtist ?? false) {
        context.read<UserArtistsBloc>().add(UserArtistsEventLoad(userId: userId));
      }
    }
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
          refreshData(userId: authState.user.id);
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: mediaQuery.size.width,
          height: mediaQuery.size.height - 30,
          decoration: const BoxDecoration(color: AppColors.backgroundPage),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is AuthStateAuthorized) {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    UserInfoWidget(user: authState.user),
                    const BalanceInfoWidget(),
                    if (authState.user.isArtist ?? false) const ArtistInfoWidget(),
                    if (authState.user.isArtist ?? false) const ArtistQRWidget(),
                    const SizedBox(height: 16),
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
                          backgroundColor: AppColors.orange,
                          child: const AppText("Выйти", textColor: AppColors.textOnColors),
                          onTap: () async {
                            context.read<UserArtistsBloc>().add(const UserArtistsEventResetSelectOnLogout());
                            context.read<FeedFiltersBloc>().add(const ResetFeedFiltersEvent());
                            context.read<WalletBloc>().add(const WalletEventReset());

                            context.read<AuthBloc>().add(const AuthEventLogout());
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 16),
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
