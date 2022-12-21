import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../../blocs/blocs.dart';

class WithdrawMoneySection extends StatefulWidget {
  const WithdrawMoneySection({super.key});

  @override
  State<WithdrawMoneySection> createState() => _WithdrawMoneySectionState();
}

class _WithdrawMoneySectionState extends State<WithdrawMoneySection> {
  final TextEditingController controller = TextEditingController(text: "0");

  bool _enableZero = false;
  bool _enableButton = false;
  bool _expandInfo = false;

  showEnsureTransactionDialog({
    required BuildContext context,
    required String cardNumber,
    required int sum,
    required int sumAfterComission,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text("Вывод денег на карту"),
          content: Text(
            "Вы действительно хотите продать $sum внутренней валюты? На вашу карту **** ${cardNumber.substring(cardNumber.length - 4)} будет начислено $sumAfterComission руб.",
          ),
          actions: [
            TextButton(
              child: const Text("Нет"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                "Да",
                style: TextStyle(color: AppColors.error),
              ),
              onPressed: () {
                context.read<WalletWithdrawMoneyBloc>().add(WalletWithdrawMoneyEventWithdrawMoney(sum: sum));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        ;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return BlocListener<WalletWithdrawMoneyBloc, WalletWithdrawMoneyState>(
      listener: (context, walletWithdrawMoneyListenerState) {
        if (walletWithdrawMoneyListenerState is WalletWithdrawMoneyStateReady) {
          context.read<WalletBloc>().add(const WalletEventGet(needUpdate: true));
        }
      },
      child: BlocBuilder<WalletWithdrawMoneyBloc, WalletWithdrawMoneyState>(
        builder: (context, walletWithdrawMoneyState) {
          return BlocBuilder<WalletBloc, WalletState>(
            builder: (context, walletState) {
              if (walletWithdrawMoneyState is WalletWithdrawMoneyStatePending) {
                return const Center(child: CircularProgressIndicator(color: AppColors.orange));
              }

              if (walletState is WalletStateLoaded) {
                if (walletState.wallet != null) {
                  return GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: SizedBox(
                      height: mediaQuery.size.height - mediaQuery.padding.top - 182,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          GestureDetector(
                            onTap: () => setState(() => _expandInfo = !_expandInfo),
                            child: Container(
                                width: mediaQuery.size.width,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundPage,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: [
                                      const AppSubtitle("Почему нельзя выбрать карту, на которую выводить?"),
                                      if (_expandInfo) const SizedBox(height: 8),
                                      if (_expandInfo)
                                        const AppText(
                                          "Почему нельзя выбрать карту, на которую выводить? Это ради вашей безопасности, поверьте. Никакой злоумышленник не сможет перевести Ваши деньги на какую-то другую карту. Правда, Вы тоже не сможете. Деньги можно выводить только на ту карту, которая привязана у Вас в кошельке. Вы можете создать новый кошелек и привязать к нему другую карту, но деньги на этом кошельке сгорят",
                                        ),
                                    ],
                                  ),
                                )),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppSubtitle("Вывод на карту "),
                              AppTitle(
                                "**** ${walletState.wallet!.cardNumber.substring((walletState.wallet!.cardNumber.length - 4))}",
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          AppTextFormField(
                            controller: controller,
                            hintText: "Какую сумму Вы хотите вывести?",
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
                          const Spacer(),
                          const SizedBox(height: 24),
                          LongButton(
                            onTap: _enableButton
                                ? () {
                                    showEnsureTransactionDialog(
                                      context: context,
                                      cardNumber: walletState.wallet!.cardNumber,
                                      sum: int.tryParse(controller.text)!,
                                      sumAfterComission: (int.tryParse(controller.text)! * 0.9).toInt(),
                                    );
                                    // BotToast.showText(
                                    //     text: "Операция прошла успешно. В скором времени денбги посутпят к Вам на карту");
                                  }
                                : null,
                            backgroundColor: AppColors.orange,
                            child: const AppText("Перевести", textColor: AppColors.textOnColors),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
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
