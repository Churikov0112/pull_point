import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/presentation/ui_kit/ui_kit.dart';
import '../../../../../domain/models/models.dart';
import '../../../../blocs/blocs.dart';

class AddArtistScreen extends StatefulWidget {
  const AddArtistScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AddArtistScreen> createState() => __AddArtistScreenState();
}

class __AddArtistScreenState extends State<AddArtistScreen> {
  late UserModel user;
  final TextEditingController artistNameEditingController = TextEditingController();
  final TextEditingController artistDescriptionEditingController = TextEditingController();
  CategoryModel? pickedCategory;
  List<SubcategoryModel> pickedSubcategories = [];

  @override
  void initState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthStateAuthorized) {
      user = authState.user;
    }
    context.read<CategoriesBloc>().add(const CategoriesEventLoad());
    super.initState();
  }

  Future<void> closePage() async {
    await Future.delayed(Duration.zero, () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return BlocListener<CheckArtistNameExistenceBloc, CheckArtistNameExistenceState>(
      listener: (context, checkArtistNameExistenceListenerState) {
        if (checkArtistNameExistenceListenerState is CheckArtistNameExistenceStateNotExists) {
          context.read<AddArtistBloc>().add(
                AddArtistEventCreate(
                  userInput: user,
                  name: artistNameEditingController.text,
                  description: artistDescriptionEditingController.text,
                  categoryId: pickedCategory!.id,
                  subcategoryIds: pickedSubcategories.map((cat) => cat.id).toList(),
                ),
              );
        }
      },
      child: BlocListener<AddArtistBloc, AddArtistState>(
        listener: (context, addArtistListenerState) {
          if (addArtistListenerState is AddArtistStateCreated) {
            closePage();
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundCard,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mediaQuery.padding.top + 12),

                  PullPointAppBar(title: "Создание артиста", onBackPressed: closePage),

                  const SizedBox(height: 40),

                  const GradientText(
                    gradient: AppGradients.main,
                    src: Text(
                      "Введите данные о себе как об артисте",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 20),

                  AppTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: "Псевдоним",
                    maxLines: 1,
                    controller: artistNameEditingController,
                  ),

                  const SizedBox(height: 8),

                  AppTextFormField(
                    keyboardType: TextInputType.multiline,
                    hintText: "Описание артиста",
                    maxLines: null,
                    controller: artistDescriptionEditingController,
                  ),
                  const SizedBox(height: 8),

                  // выбор главной категории
                  BlocBuilder<CategoriesBloc, CategoriesState>(
                    builder: (context, state) {
                      if (state is CategoriesStateLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
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

                  BlocBuilder<CheckArtistNameExistenceBloc, CheckArtistNameExistenceState>(
                    builder: (context, checkArtistNameExistenceState) {
                      if (checkArtistNameExistenceState is CheckArtistNameExistenceStatePending) {
                        return const LongButton(
                          backgroundColor: AppColors.orange,
                          isDisabled: true,
                          child: LoadingIndicator(),
                        );
                      }
                      return LongButton(
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

                          context
                              .read<CheckArtistNameExistenceBloc>()
                              .add(CheckArtistNameExistenceEventCheck(artistName: artistNameEditingController.text));
                        },
                        child: const AppButtonText("Создать", textColor: AppColors.textOnColors),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
