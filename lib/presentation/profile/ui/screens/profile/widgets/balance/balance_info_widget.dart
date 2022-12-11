import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/domain/domain.dart';
import 'package:pull_point/presentation/blocs/user/wallet_bloc/wallet_bloc.dart';
import '../../../../../../ui_kit/ui_kit.dart';
import '../../../balance/balance_screen.dart';
import '../../../create_wallet/create_wallet_screen.dart';

class BalanceInfoWidget extends StatelessWidget {
  const BalanceInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        if (state is WalletStateLoaded) {
          if (state.wallet != null) {
            return _WalletLoaded(wallet: state.wallet!);
          } else {
            return _WalletCreate();
          }
        }

        if (state is WalletStateFailed) {
          return _WalletError(reason: state.reason);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _WalletLoaded extends StatelessWidget {
  const _WalletLoaded({
    required this.wallet,
  });

  final WalletModel wallet;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return TouchableOpacity(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const BalanceScreen(),
          ),
        );
      },
      child: Container(
        width: mediaQuery.size.width,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(
            children: [
              const AppTitle("Баланс"),
              const Spacer(),
              AppTitle(wallet.balance.toString()),
              const SizedBox(width: 8),
              Image.asset(
                "assets/raster/images/coin.png",
                height: 20,
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WalletCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return TouchableOpacity(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => CreateWalletScreen(),
          ),
        );
      },
      child: Container(
        width: mediaQuery.size.width,
        decoration: const BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: AppTitle("Добавьте карту, чтобы создать кошелек"),
        ),
      ),
    );
  }
}

class _WalletError extends StatelessWidget {
  const _WalletError({required this.reason});

  final String reason;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: mediaQuery.size.width,
      decoration: const BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: AppTitle(reason),
      ),
    );
  }
}
