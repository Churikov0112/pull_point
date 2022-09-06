import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';
import '../../../../../domain/models/models.dart';
import '../../../../home/home_page.dart';
import '../../../../map/blocs/blocs.dart';
import '../../../blocs/blocs.dart';

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
  final TextEditingController artistNameEditingController = TextEditingController();
  final TextEditingController artistDescriptionEditingController = TextEditingController();
  CategoryModel? pickedCategory;
  List<SubcategoryModel> pickedSubcategories = [];

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthStateAuthorized) _goToHomePage();
          return Scaffold(
            backgroundColor: AppColors.backgroundPage,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const GradientText(
                    gradient: AppGradients.main,
                    src: Text(
                      "Введите данные о себе как об артисте",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                  AppTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: "Псевдоним",
                    maxLines: 1,
                    controller: artistNameEditingController,
                  ),
                  AppTextFormField(
                    keyboardType: TextInputType.multiline,
                    hintText: "Описание артиста",
                    maxLines: null,
                    controller: artistDescriptionEditingController,
                  ),

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
                                  CategoryChip(
                                    childText: cat.name,
                                    gradient: pickedCategory?.id == cat.id ? AppGradients.main : AppGradients.first,
                                    onPressed: () {
                                      setState(() {
                                        pickedCategory = cat;
                                        pickedSubcategories.clear();
                                      });
                                      context.read<SubcategoriesBloc>().add(SubcategoriesEventLoad(parentCategoryId: cat.id));
                                    },
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
                                    CategoryChip(
                                      childText: cat.name,
                                      gradient: pickedSubcategories.contains(cat) ? AppGradients.main : AppGradients.first,
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
                    backgroundGradient: AppGradients.main,
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
                      context.read<AuthBloc>().add(
                            AuthEventRegisterArtist(
                              user: widget.user,
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
