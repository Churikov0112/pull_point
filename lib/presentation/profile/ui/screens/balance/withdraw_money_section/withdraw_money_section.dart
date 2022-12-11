import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return BlocBuilder<WalletBloc, WalletState>(builder: (context, walletState) {
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
                  if (walletState is WalletStateLoaded)
                    if (walletState.wallet != null)
                      AppTitle(
                        "**** ${walletState.wallet!.cardNumber.substring((walletState.wallet!.cardNumber.length - 4))}",
                      ),
                ],
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                hintText: "Какую сумму Вы хотите вывести?",
                maxLines: 1,
                keyboardType: TextInputType.number,
                onChanged: (newText) {
                  _enableButton = false;

                  if (newText.isNotEmpty) {
                    final intNewText = int.tryParse(newText);
                    if (walletState is WalletStateLoaded) {
                      if (walletState.wallet != null) {
                        _enableButton = (intNewText! <= walletState.wallet!.balance && intNewText > 0);
                      }
                    }
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
                // TODO <= 100 заменить на реальное значение sum кошлька
                onTap: _enableButton
                    ? () {
                        BotToast.showText(
                            text: "Операция прошла успешно. В скором времени денбги посутпят к Вам на карту");
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
    });
  }
}
