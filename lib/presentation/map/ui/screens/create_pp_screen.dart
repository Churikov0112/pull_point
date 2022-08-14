import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import '../../../../domain/models/models.dart';
import '../../../ui_kit/ui_kit.dart';
import '../../blocs/blocs.dart';
import 'pick_location_screen.dart';

class CreatePullPointScreen extends StatefulWidget {
  const CreatePullPointScreen({Key? key}) : super(key: key);

  @override
  State<CreatePullPointScreen> createState() => _CreatePullPointScreenState();
}

class _CreatePullPointScreenState extends State<CreatePullPointScreen> {
  LatLng? pickedLocation;

  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController = TextEditingController();

  DateTime? pickedStartDate;
  DateTime? pickedEndDate;

  TimeOfDay? pickedStartTime;
  TimeOfDay? pickedEndTime;

  CategoryModel? pickedCategory;

  List<SubcategoryModel> pickedSubcategories = [];

  // getSubcategoryItems({required int pickedCategoryId}) {
  //   List<MultiSelectItem<SubcategoryModel>> items = Categories.getSubcategoriesOfCategory(categoryId: pickedCategoryId)
  //       .map((subcat) => MultiSelectItem<SubcategoryModel>(subcat, subcat.name))
  //       .toList();
  //   if (items.isNotEmpty) return items;
  //   return null;
  // }

  @override
  void initState() {
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

                  // appbar
                  SizedBox(
                    width: mediaQuery.size.width - 32,
                    child: Row(
                      children: [
                        TouchableOpacity(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const SizedBox.square(dimension: 24, child: Center(child: Icon(Icons.arrow_back_ios_new, size: 20))),
                        ),
                        const SizedBox(width: 8),
                        const GradientText(
                          gradient: AppGradients.main,
                          src: Text(
                            "Создание выступления",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
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
                    child: const AppText("Далее", textColor: Colors.white),
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
                      Navigator.of(context).pop();
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
