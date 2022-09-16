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
        backgroundColor: AppColors.backgroundPage,
        // appBar: AppBar(title: const Text("Создание выступления"), backgroundColor: AppColors.primary),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ScrollConfiguration(
            behavior: CustomScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  PullPointAppBar(
                    title: "Создание выступления",
                    onBackPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),

                  const SizedBox(height: 32),

                  // pick location
                  TouchableOpacity(
                    onPressed: () async {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (BuildContext context) => PickLocationScreen(onSubmit: updateLocation, initialCenter: pickedLocation)));
                    },
                    child: Container(
                      width: mediaQuery.size.width,
                      height: 100,
                      decoration: const BoxDecoration(color: AppColors.backgroundCard, borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                        child: Text(pickedLocation == null
                            ? "Выбрать место проведения 📍"
                            : "lat: ${pickedLocation!.latitude.toStringAsFixed(4)} , lon: ${pickedLocation!.longitude.toStringAsFixed(4)}"),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

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

                  const SizedBox(height: 16),

                  // выбор главной категории
                  BlocBuilder<UserArtistsBloc, UserArtistsState>(
                    builder: (context, state) {
                      if (state is UserArtistsStateSelected) {
                        pickedArtist ??= state.selectedArtist;
                        if (pickedArtist != null) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const AppTitle("Кьл создает выступление?"),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final artist in state.allUserArtists)
                                    CategoryChip(
                                      childText: artist.name ?? "no_name",
                                      gradient: pickedArtist!.id == artist.id ? AppGradients.main : AppGradients.first,
                                      onPressed: () {
                                        setState(() => pickedArtist = artist);
                                      },
                                    ),
                                ],
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

                  const SizedBox(height: 16),
                  const AppTitle("Когда пройдет выступление?"),
                  const SizedBox(height: 16),

                  // ввод даты начала выступления
                  Row(
                    children: [
                      ChipWidget(
                        onPressed: () async {
                          final result = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 7)),
                            initialDate: DateTime.now(),
                          );
                          if (result != null) setState(() => pickedStartDate = result);
                        },
                        text: "Дата начала",
                      ),
                      const SizedBox(width: 16),
                      if (pickedStartDate != null) Text("${pickedStartDate!.day}.${pickedStartDate!.month}.${pickedStartDate!.year}"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ввод даты конца выступления
                  Row(
                    children: [
                      ChipWidget(
                        onPressed: () async {
                          final result = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 7)),
                            initialDate: DateTime.now(),
                          );
                          if (result != null) setState(() => pickedEndDate = result);
                        },
                        text: "Дата конца",
                      ),
                      const SizedBox(width: 16),
                      if (pickedEndDate != null) Text("${pickedEndDate!.day}.${pickedEndDate!.month}.${pickedStartDate!.year}"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ввод времени начала выступления
                  Row(
                    children: [
                      ChipWidget(
                        onPressed: () async {
                          final result = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.input,
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                            },
                          );
                          if (result != null) setState(() => pickedStartTime = result);
                        },
                        text: "Время начала",
                      ),
                      const SizedBox(width: 16),
                      if (pickedStartTime != null) Text("${pickedStartTime!.hour}:${pickedStartTime!.minute}"),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ввод времени конца выступления
                  Row(
                    children: [
                      ChipWidget(
                        onPressed: () async {
                          final result = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            initialEntryMode: TimePickerEntryMode.input,
                            builder: (BuildContext context, Widget? child) {
                              return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                            },
                          );
                          if (result != null) setState(() => pickedEndTime = result);
                        },
                        text: "Время конца",
                      ),
                      const SizedBox(width: 16),
                      if (pickedEndTime != null) Text("${pickedEndTime!.hour}:${pickedEndTime!.minute}"),
                    ],
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
                                  CategoryChip(
                                    childText: cat.name,
                                    gradient: pickedCategory?.id == cat.id ? AppGradients.main : AppGradients.first,
                                    onPressed: () {
                                      setState(() => pickedCategory = cat);
                                      context.read<SubcategoriesBloc>().add(SubcategoriesEventLoad(parentCategoryIds: [cat.id]));
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

                  BlocBuilder<CreatePullPointBloc, CreatePullPointState>(
                    builder: (context, state) {
                      if (state is CreatePullPointStateCreated) {
                        closePage();
                      }
                      return LongButton(
                        backgroundGradient: AppGradients.main,
                        child: (state is CreatePullPointStateLoading) ? const LoadingIndicator() : const AppText("Далее", textColor: Colors.white),
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
