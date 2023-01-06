import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../domain/models/models.dart';
import '../../../../blocs/blocs.dart';
import '../../../../ui_kit/ui_kit.dart';
import 'pick_location_screen.dart';

class CreatePullPointScreen extends StatefulWidget {
  const CreatePullPointScreen({Key? key}) : super(key: key);

  @override
  State<CreatePullPointScreen> createState() => _CreatePullPointScreenState();
}

class _CreatePullPointScreenState extends State<CreatePullPointScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();

  LatLng? pickedLocation;

  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

  TimeOfDay? pickedStartTime;
  TimeOfDay? pickedEndTime;

  CategoryModel? pickedCategory;

  ArtistModel? pickedArtist; // required!!!

  List<SubcategoryModel> pickedSubcategories = [];

  Future<void> closePage() async {
    await Future.delayed(Duration.zero, () {
      context.read<PullPointsBloc>().add(const PullPointsEventLoad());
      context.read<CreatePullPointBloc>().add(CreatePullPointEventReset());
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthStateAuthorized) {
      final userArtistsState = context.read<UserArtistsBloc>().state;
      if (userArtistsState is UserArtistsStateInitial) {
        context.read<UserArtistsBloc>().add(UserArtistsEventLoad(userId: authState.user.id));
      }
      if (userArtistsState is UserArtistsStateSelected) {
        pickedArtist = userArtistsState.selectedArtist;
      }
    }
    context.read<CreatePullPointBloc>().add(CreatePullPointEventReset());
    context.read<CategoriesBloc>().add(const CategoriesEventLoad());
    super.initState();
  }

  void updateLocation(LatLng? location) {
    setState(() {
      pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundCard,
        // appBar: AppBar(title: const Text("Создание выступления"), backgroundColor: AppColors.primary),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: mediaQuery.padding.top + 24),

                  PullPointAppBar(
                    title: "Создание выступления",
                    onBackPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  const SizedBox(height: 32),

                  // ввод названия выступления
                  AppTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: "Название выступления",
                    maxLines: 1,
                    controller: titleEditingController,
                  ),

                  const SizedBox(height: 16),

                  // ввод описания выступления
                  AppTextFormField(
                    keyboardType: TextInputType.multiline,
                    hintText: "Описание выступления",
                    maxLines: null,
                    controller: descriptionEditingController,
                  ),

                  const SizedBox(height: 40),

                  // const AppTitle("Выберите категорию"),

                  // выбор главной категории
                  SizedBox(
                    width: mediaQuery.size.width,
                    child: BlocBuilder<CategoriesBloc, CategoriesState>(
                      builder: (context, state) {
                        if (state is CategoriesStateLoaded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const AppTitle("Выберите категорию"),
                              const SizedBox(height: 8),
                              for (final cat in state.categories)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: SizedBox(
                                    width: mediaQuery.size.width,
                                    child: MainButton(
                                      childText: cat.name,
                                      backgroundColor:
                                          pickedCategory?.id == cat.id ? AppColors.orange : AppColors.backgroundCard,
                                      textColor:
                                          pickedCategory?.id == cat.id ? AppColors.textOnColors : AppColors.orange,
                                      onPressed: () {
                                        setState(() => pickedCategory = cat);
                                        context
                                            .read<SubcategoriesBloc>()
                                            .add(SubcategoriesEventLoad(parentCategoryIds: [cat.id]));
                                      },
                                    ),
                                  ),
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
                  ),

                  const SizedBox(height: 40),

                  const Align(child: AppTitle("Выберите подкатегории (макс.3)")),
                  const SizedBox(height: 16),

                  // выбор подкатегории
                  if (pickedCategory != null)
                    BlocBuilder<SubcategoriesBloc, SubcategoriesState>(
                      builder: (context, state) {
                        if (state is SubcategoriesStateLoaded) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final cat in state.subcategories)
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        MainButton(
                                          childText: cat.name,
                                          borderColor: AppColors.blue,
                                          backgroundColor: pickedSubcategories.contains(cat)
                                              ? AppColors.blue
                                              : AppColors.backgroundCard,
                                          textColor: pickedSubcategories.contains(cat)
                                              ? AppColors.textOnColors
                                              : AppColors.blue,
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
                              )
                            ],
                          );
                        }
                        if (state is SubcategoriesStateLoading) {
                          return const LoadingIndicator();
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                  const SizedBox(height: 40),

                  const Align(child: AppTitle("Место проведения")),

                  const SizedBox(height: 16),

                  // pick location
                  TouchableOpacity(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              PickLocationScreen(onSubmit: updateLocation, initialCenter: pickedLocation)));
                    },
                    child: Container(
                      width: mediaQuery.size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.orange, width: 1),
                        color: pickedLocation == null ? AppColors.backgroundCard : AppColors.orange,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: AppText(
                          pickedLocation == null
                              ? "Выбрать место проведения 📍"
                              : "широта: ${pickedLocation!.latitude.toStringAsFixed(4)} , долгота: ${pickedLocation!.longitude.toStringAsFixed(4)}",
                          textColor: pickedLocation == null ? AppColors.orange : AppColors.backgroundCard,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // выбор артиста
                  SizedBox(
                    width: mediaQuery.size.width,
                    child: BlocBuilder<UserArtistsBloc, UserArtistsState>(
                      builder: (context, state) {
                        if (state is UserArtistsStateSelected) {
                          pickedArtist ??= state.selectedArtist;
                          if (pickedArtist != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const AppTitle("Кто создает выступление?"),
                                const SizedBox(height: 8),
                                for (final artist in state.allUserArtists)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: MainButton(
                                      childText: artist.name ?? "no_name",
                                      backgroundColor:
                                          pickedArtist!.id == artist.id ? AppColors.orange : AppColors.backgroundCard,
                                      textColor:
                                          pickedArtist!.id == artist.id ? AppColors.textOnColors : AppColors.orange,
                                      onPressed: () {
                                        setState(() => pickedArtist = artist);
                                      },
                                    ),
                                  ),
                              ],
                            );
                          }
                        }
                        if (state is UserArtistsStateLoading) {
                          return const LoadingIndicator();
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),

                  const SizedBox(height: 40),
                  const Align(child: AppTitle("Когда пройдет выступление?")),
                  const SizedBox(height: 16),

                  // ввод даты начала и конца выступления
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MainButton(
                          childText: pickedStartDate != null
                              ? "${pickedStartDate!.day}.${pickedStartDate!.month}.${pickedStartDate!.year}"
                              : "Дата начала",
                          textColor: pickedStartDate != null ? AppColors.textOnColors : AppColors.orange,
                          backgroundColor: pickedStartDate != null ? AppColors.orange : AppColors.backgroundCard,
                          onPressed: () async {
                            final result = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 7)),
                              initialDate: DateTime.now(),
                            );
                            if (result != null) setState(() => pickedStartDate = result);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MainButton(
                          childText: pickedEndDate != null
                              ? "${pickedEndDate!.day}.${pickedEndDate!.month}.${pickedEndDate!.year}"
                              : "Дата конца",
                          textColor: pickedEndDate != null ? AppColors.textOnColors : AppColors.orange,
                          backgroundColor: pickedEndDate != null ? AppColors.orange : AppColors.backgroundCard,
                          onPressed: () async {
                            final result = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 7)),
                              initialDate: DateTime.now(),
                            );
                            if (result != null) setState(() => pickedEndDate = result);
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ввод времени начала и конца выступления
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: MainButton(
                          childText: pickedStartTime != null
                              ? "${pickedStartTime!.hour}:${pickedStartTime!.minute}"
                              : "Время начала",
                          textColor: pickedStartTime != null ? AppColors.textOnColors : AppColors.orange,
                          backgroundColor: pickedStartTime != null ? AppColors.orange : AppColors.backgroundCard,
                          onPressed: () async {
                            final result = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                              },
                            );
                            if (result != null) setState(() => pickedStartTime = result);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: MainButton(
                          childText:
                              pickedEndTime != null ? "${pickedEndTime!.hour}:${pickedEndTime!.minute}" : "Время конца",
                          textColor: pickedEndTime != null ? AppColors.textOnColors : AppColors.orange,
                          backgroundColor: pickedEndTime != null ? AppColors.orange : AppColors.backgroundCard,
                          onPressed: () async {
                            final result = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                              },
                            );
                            if (result != null) setState(() => pickedEndTime = result);
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  BlocListener<CreatePullPointBloc, CreatePullPointState>(
                    listener: (context, createPullPointListenerState) {
                      if (createPullPointListenerState is CreatePullPointStateCreated) {
                        closePage();
                      }
                    },
                    child: BlocBuilder<CreatePullPointBloc, CreatePullPointState>(
                      builder: (context, createPullPointBuilderState) {
                        return LongButton(
                          backgroundColor: AppColors.orange,
                          isDisabled: createPullPointBuilderState is CreatePullPointStateLoading,
                          child: (createPullPointBuilderState is CreatePullPointStateLoading)
                              ? const LoadingIndicator()
                              : const AppText("Далее", textColor: Colors.white),
                          onTap: () {
                            if (pickedLocation == null) {
                              BotToast.showText(text: "Вы не выбрали место");
                              return;
                            }
                            if (titleEditingController.text.isEmpty) {
                              BotToast.showText(text: "Вы не ввели название");
                              return;
                            }
                            if (descriptionEditingController.text.isEmpty) {
                              BotToast.showText(text: "Вы не ввели описание");
                              return;
                            }
                            if (pickedStartDate == null || pickedEndDate == null) {
                              BotToast.showText(text: "Вы не выбрали дату");
                              return;
                            }
                            if (pickedStartTime == null || pickedEndTime == null) {
                              BotToast.showText(text: "Вы не выбрали время");
                              return;
                            }
                            if (pickedCategory == null) {
                              BotToast.showText(text: "Вы не выбрали категорию");
                              return;
                            }
                            if (pickedArtist == null) {
                              BotToast.showText(text: "Вы не выбрали артиста");
                              return;
                            }

                            final authState = context.read<AuthBloc>().state;
                            if (authState is AuthStateAuthorized) {
                              context.read<CreatePullPointBloc>().add(
                                    CreatePullPointEventCreate(
                                      name: titleEditingController.text,
                                      description: descriptionEditingController.text,
                                      ownerId: pickedArtist!.id,
                                      latitude: pickedLocation!.latitude,
                                      longitude: pickedLocation!.longitude,
                                      startTime: DateTime(
                                        pickedStartDate!.year,
                                        pickedStartDate!.month,
                                        pickedStartDate!.day,
                                        pickedStartTime!.hour,
                                        pickedStartTime!.minute,
                                      ),
                                      endTime: DateTime(
                                        pickedEndDate!.year,
                                        pickedEndDate!.month,
                                        pickedEndDate!.day,
                                        pickedEndTime!.hour,
                                        pickedEndTime!.minute,
                                      ),
                                      categoryId: pickedCategory!.id,
                                      subcategoryIds: [for (final subcat in pickedSubcategories) subcat.id],
                                    ),
                                  );
                            } else {
                              BotToast.showText(text: "Необходимо авторизоваться");
                              return;
                            }

                            // Navigator.of(context).pop();
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
