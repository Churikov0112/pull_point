import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/auth/ui/screens/wanna_be_artist_screen/wanna_be_artist_screen.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';

import '../../../../../domain/models/models.dart';
import '../../../../blocs/blocs.dart';
import '../../../../home/home_page.dart';

class EnterArtistDataScreen extends StatefulWidget {
  const EnterArtistDataScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  final UserModel user;

  @override
  State<EnterArtistDataScreen> createState() => __EnterArtistDataScreenState();
}

class __EnterArtistDataScreenState extends State<EnterArtistDataScreen> {
  late UserModel user;
  final TextEditingController artistNameEditingController = TextEditingController();
  final TextEditingController artistDescriptionEditingController = TextEditingController();
  CategoryModel? pickedCategory;
  List<SubcategoryModel> pickedSubcategories = [];

  @override
  void initState() {
    user = widget.user;
    context.read<CategoriesBloc>().add(const CategoriesEventLoad());
    super.initState();
  }

  Future<void> _goToHomePage() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<void> _goToWannaBeArtistScreen({required UserModel user}) async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => WannaBeArtistScreen(user: user),
        ),
        (Route<dynamic> route) => false,
      );
    });
  }

  Future<bool> _onWillPop() async {
    context.read<AuthBloc>().add(AuthEventOpenWannaBeArtistPage(user: user));
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateAuthorized) _goToHomePage();
          if (state is AuthStateUsernameInputed) _goToWannaBeArtistScreen(user: state.user);

          return Scaffold(
            backgroundColor: AppColors.backgroundCard,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const GradientText(
                    gradient: AppGradients.main,
                    src: Text(
                      "Введите данные о себе как об артисте",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: "Псевдоним",
                    maxLines: 1,
                    controller: artistNameEditingController,
                  ),
                  const SizedBox(height: 16),

                  AppTextFormField(
                    keyboardType: TextInputType.multiline,
                    hintText: "Описание артиста",
                    maxLines: null,
                    controller: artistDescriptionEditingController,
                  ),
                  const SizedBox(height: 16),

                  // выбор главной категории
                  BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesStateLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppTitle("Выберите категорию"),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: [
                                for (final cat in state.categories)
                                  TouchableOpacity(
                                    onPressed: () {
                                      setState(() {
                                        pickedCategory = cat;
                                        pickedSubcategories.clear();
                                      });
                                      context
                                          .read<SubcategoriesBloc>()
                                          .add(SubcategoriesEventLoad(parentCategoryIds: [cat.id]));
                                    },
                                    child: CategoryChip(
                                      childText: cat.name,
                                      gradient: pickedCategory?.id == cat.id ? AppGradients.main : AppGradients.first,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        );
                      }
                      if (state is CategoriesStateLoading) {
                        return const LoadingIndicator();
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 16),

                  // выбор подкатегории
                  if (pickedCategory != null)
                    BlocBuilder<SubcategoriesBloc, SubcategoriesState>(
                      builder: (context, state) {
                        if (state is SubcategoriesStateLoaded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              const AppTitle("Выберите подкатегории (макс.3)"),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final cat in state.subcategories)
                                    TouchableOpacity(
                                      onPressed: () {
                                        if (pickedSubcategories.contains(cat)) {
                                          pickedSubcategories.remove(cat);
                                        } else {
                                          if (pickedSubcategories.length < 3) {
                                            pickedSubcategories.add(cat);
                                          } else {
                                            BotToast.showText(text: "Нельзя выбрать больше трех подкатегорий");
                                          }
                                        }
                                        setState(() {});
                                      },
                                      child: CategoryChip(
                                        childText: cat.name,
                                        gradient:
                                            pickedSubcategories.contains(cat) ? AppGradients.main : AppGradients.first,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        }
                        if (state is SubcategoriesStateLoading) {
                          return const LoadingIndicator();
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                  const SizedBox(height: 32),

                  LongButton(
                    backgroundColor: AppColors.orange,
                    onTap: () {
                      if (artistNameEditingController.text.isEmpty) {
                        BotToast.showText(text: "Введите имя");
                        return;
                      }
                      if (artistDescriptionEditingController.text.isEmpty) {
                        BotToast.showText(text: "Введите описание");
                        return;
                      }
                      if (pickedCategory == null) {
                        BotToast.showText(text: "Выберите категорию");
                        return;
                      }
                      FocusScope.of(context).unfocus();
                      context.read<AuthBloc>().add(
                            AuthEventRegisterArtist(
                              user: UserModel(
                                id: widget.user.id,
                                username: widget.user.username,
                                email: widget.user.email,
                                accessToken: widget.user.accessToken,
                                isArtist: true,
                              ),
                              name: artistNameEditingController.text,
                              description: artistDescriptionEditingController.text,
                              categoryId: pickedCategory!.id,
                              subcategoryIds: pickedSubcategories.map((cat) => cat.id).toList(),
                            ),
                          );
                      // Navigator.of(context).pop();
                    },
                    child: const AppButtonText("Создать", textColor: AppColors.textOnColors),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
