import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/home/home_page.dart';

import '../../domain/models/models.dart';
import '../blocs/blocs.dart';
import '../ui_kit/ui_kit.dart';

class DonationScreen extends StatefulWidget {
  const DonationScreen({
    required this.artist,
    Key? key,
  }) : super(key: key);

  final ArtistModel artist;

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  final TextEditingController controller = TextEditingController(text: "0");

  @override
  void initState() {
    context.read<WalletBloc>().add(const WalletEventGet(needUpdate: true));
    super.initState();
  }

  bool _enableButton = false;
  bool _enableZero = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocListener<WalletTransferMoneyBloc, WalletTransferMoneyState>(
      listener: (context, walletTransferMoneyListenerState) {
        if (walletTransferMoneyListenerState is WalletTransferMoneyStateReady) {
          context.read<WalletBloc>().add(const WalletEventGet(needUpdate: true));
        }
      },
      child: BlocBuilder<WalletTransferMoneyBloc, WalletTransferMoneyState>(
        builder: (context, walletTransferMoneyState) {
          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, walletState) {
              if (walletState is WalletStateNoWallet) {
                return _NoWallet(artist: widget.artist);
              }
              if (walletState is WalletStatePending || walletTransferMoneyState is WalletTransferMoneyStatePending) {
                return const _Loading();
              }
              if (walletState is WalletStateLoaded) {
                if (walletState.wallet != null) {
                  return Scaffold(
                    backgroundColor: AppColors.backgroundCard,
                    body: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ScrollConfiguration(
                        behavior: CustomScrollBehavior(),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: mediaQuery.padding.top + 24),
                              PullPointAppBar(
                                title: "Пожертвование ${widget.artist.name}",
                                titleMaxLines: 2,
                                onBackPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              const SizedBox(height: 32),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      AppTitle("Текущий баланс: ${walletState.wallet!.balance}"),
                                      const SizedBox(width: 8),
                                      Image.asset(
                                        "assets/raster/images/coin.png",
                                        height: 20,
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                              const SizedBox(height: 16),
                              AppTextFormField(
                                controller: controller,
                                hintText: "Какую сумму Вы хотите пожертвовать?",
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                onChanged: (newText) {
                                  _enableButton = false;

                                  if (newText.isNotEmpty) {
                                    final intNewText = int.tryParse(newText);
                                    _enableButton = (intNewText! <= walletState.wallet!.balance && intNewText > 0);
                                  }
                                  setState(() => _enableZero = newText.isNotEmpty);
                                },
                                inputFormatters: !_enableZero
                                    ? [FilteringTextInputFormatter.allow(RegExp(r'[1-9]'))]
                                    : [FilteringTextInputFormatter.digitsOnly],
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ),
                    ),
                    floatingActionButton: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: LongButton(
                        onTap: () {
                          if (int.tryParse(controller.text) != null && widget.artist.name != null) {
                            context.read<WalletTransferMoneyBloc>().add(
                                  WalletTransferMoneyEventTransferMoney(
                                    sum: int.tryParse(controller.text)!,
                                    artistName: widget.artist.name!,
                                  ),
                                );
                          }
                        },
                        isDisabled: !_enableButton,
                        backgroundColor: AppColors.orange,
                        child: const AppText("Пожертвовать", textColor: AppColors.textOnColors),
                      ),
                    ),
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  );
                }
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}

class _NoWallet extends StatelessWidget {
  const _NoWallet({
    required this.artist,
  });

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundCard,
      body: Column(
        children: [
          SizedBox(height: mediaQuery.padding.top + 24),
          PullPointAppBar(
            title: "Пожертвование ${artist.name}",
            titleMaxLines: 2,
            onBackPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(height: mediaQuery.size.height / 3),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 64),
            child: AppText(
              "Чтобы пожертвовать артисту, необходимо завести кошелек в приложении и пополнить его. Сделать это можно в разделе Профиль. Это проще, чем кажется :)",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: LongButton(
          onTap: () {
            context.read<HomeBloc>().add(const HomeEventSelectTab(tabIndex: 4));
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute<void>(builder: (BuildContext context) => const HomePage()),
              ModalRoute.withName('/'),
            );
          },
          backgroundColor: AppColors.orange,
          child: const AppText("В профиль", textColor: AppColors.textOnColors),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.backgroundCard,
      body: Center(child: CircularProgressIndicator(color: AppColors.orange)),
    );
  }
}
