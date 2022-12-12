import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, walletState) {
        if (walletState is WalletStateNoWallet) {
          return Scaffold(
            backgroundColor: AppColors.backgroundCard,
            body: Column(
              children: [
                SizedBox(height: mediaQuery.padding.top + 24),
                PullPointAppBar(
                  title: "Пожертвование ${widget.artist.name}",
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
                  Navigator.of(context).pop();
                },
                backgroundColor: AppColors.orange,
                child: const AppText("В профиль", textColor: AppColors.textOnColors),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        }
        if (walletState is WalletStatePending) {
          return const Scaffold(
            backgroundColor: AppColors.backgroundCard,
            body: Center(child: CircularProgressIndicator(color: AppColors.orange)),
          );
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
                  onTap: () {},
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
  }
}

class PPHistoryItem extends StatelessWidget {
  const PPHistoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: () {},
      child: Container(
        height: 120,
        width: 180,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          color: AppColors.backgroundPage.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSubtitle(
                "Название выступления",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              const AppText(
                "Описание выступления Описание выступления Описание выступления Описание выступления Описание выступления",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              AppText(
                "23.12.2022",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textColor: AppColors.text.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
