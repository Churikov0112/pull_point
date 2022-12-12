import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';

class CreateWalletScreen extends StatelessWidget {
  CreateWalletScreen({super.key});

  final TextEditingController cardNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocListener<CreateWalletBloc, CreateWalletState>(
      listener: (context, createWalletState) {
        if (createWalletState is CreateWalletStateCreated) {
          context.read<WalletBloc>().add(const WalletEventGet(needUpdate: true));
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: mediaQuery.size.width,
          decoration: const BoxDecoration(color: AppColors.backgroundCard),
          child: SingleChildScrollView(
            child: SizedBox(
              height: mediaQuery.size.height,
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.padding.top + 24),
                  PullPointAppBar(
                    title: "Добавить карту",
                    onBackPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(height: 24),
                  AppTextFormField(
                    controller: cardNumberController,
                    hintText: "Введите номер карты",
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    onChanged: (newText) {},
                    inputFormatters: [
                      MaskTextInputFormatter(
                        mask: '#### #### #### ####',
                        filter: {"#": RegExp(r'[0-9]')},
                        type: MaskAutoCompletionType.lazy,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const SizedBox(height: 24),
                  LongButton(
                    onTap: () {
                      final cardNumber = cardNumberController.text.replaceAll(" ", "");
                      context.read<CreateWalletBloc>().add(CreateWalletEventCreate(cardNumber: cardNumber));
                    },
                    backgroundColor: AppColors.orange,
                    child: const AppText("Создать кошелек", textColor: AppColors.textOnColors),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
