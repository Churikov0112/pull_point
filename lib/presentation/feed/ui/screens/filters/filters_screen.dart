import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_point/data/repositories/mock/metro_stations.dart';

import '../../../../../domain/domain.dart';

import '../../../../blocs/blocs.dart';
import '../../../../static_methods/static_methods.dart';
import '../../../../ui_kit/ui_kit.dart';
import 'widgets/widgets.dart';

class FeedFiltersScreen extends StatefulWidget {
  const FeedFiltersScreen({Key? key}) : super(key: key);

  @override
  State<FeedFiltersScreen> createState() => _FeedFiltersScreenState();
}

class _FeedFiltersScreenState extends State<FeedFiltersScreen> {
  late FeedFiltersBloc feedFiltersBloc;

  DateTimeRange? dateRange;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<MetroStationModel> metroStations = [];
  List<CategoryModel> pickedCategories = [];
  List<SubcategoryModel> pickedSubcategories = [];

  // проверить на наличие фильтров
  @override
  void initState() {
    context.read<CategoriesBloc>().add(const CategoriesEventLoad());
    feedFiltersBloc = context.read<FeedFiltersBloc>();
    if (feedFiltersBloc.state is FeedFiltersFilteredState) {
      FeedFiltersFilteredState state = feedFiltersBloc.state as FeedFiltersFilteredState;
      dateRange = (state.filters['date'] as DateFilter?)?.dateRange;
      startTime = (state.filters['time'] as TimeFilter?)?.timeRange.start;
      endTime = (state.filters['time'] as TimeFilter?)?.timeRange.end;
      metroStations = (state.filters['metro'] as NearestMetroFilter?)?.selectedMetroStations ?? [];
      pickedCategories = (state.filters['categories'] as CategoriesFilter?)?.selectedCategories ?? [];
      pickedSubcategories = (state.filters['categories'] as CategoriesFilter?)?.selectedSubcategories ?? [];
    }

    if (pickedCategories.isNotEmpty) {
      context
          .read<SubcategoriesBloc>()
          .add(SubcategoriesEventLoad(parentCategoryIds: pickedCategories.map((e) => e.id).toList()));
    }

    super.initState();
  }

  void _resetAll() {
    dateRange = null;
    startTime = null;
    endTime = null;
    metroStations.clear();
    pickedCategories.clear();
    pickedSubcategories.clear();
    setState(() {});
  }

  @override
  void deactivate() {
    context.read<CategoriesBloc>().add(const CategoriesEventReset());
    context.read<SubcategoriesBloc>().add(const SubcategoriesEventReset());
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Фильтры"),
        backgroundColor: AppColors.primary,
        actions: [
          TouchableOpacity(
            onPressed: _resetAll,
            child: const SizedBox(height: 30, width: 100, child: Center(child: Text("Сбросить"))),
          ),
        ],
      ),
      body: BlocBuilder<FeedFiltersBloc, FeedFiltersState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const AppTitle("Дата"),
                const SizedBox(height: 8),
                TouchableOpacity(
                  onPressed: () async {
                    if (dateRange == null) {
                      final result = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 7)),
                      );
                      if (result != null) setState(() => dateRange = result);
                    } else {
                      setState(() => dateRange = null);
                    }
                  },
                  child: CategoryChip(
                    gradient: dateRange == null ? AppGradients.slave : AppGradients.main,
                    textColor: dateRange == null ? AppColors.text : AppColors.textOnColors,
                    childText: dateRange == null
                        ? "Выбрать дату начала и дату конца"
                        : "с ${DateFormat("dd.MM.yyyy").format(dateRange!.start)} до ${DateFormat("dd.MM.yyyy").format(dateRange!.end)}",
                  ),
                ),
                const SizedBox(height: 24),
                const AppTitle("Время"),
                const SizedBox(height: 8),
                SizedBox(
                  width: mediaQuery.size.width,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TouchableOpacity(
                        onPressed: () async {
                          if (startTime == null) {
                            final result = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                              },
                            );
                            if (result != null) setState(() => startTime = result);
                          } else {
                            setState(() => startTime = null);
                          }
                        },
                        child: CategoryChip(
                          gradient: startTime == null ? AppGradients.slave : AppGradients.main,
                          textColor: startTime == null ? AppColors.text : AppColors.textOnColors,
                          childText:
                              startTime == null ? "Выбрать время начала" : "с ${startTime!.hour}:${startTime!.minute}",
                        ),
                      ),
                      TouchableOpacity(
                        onPressed: () async {
                          if (endTime == null) {
                            final result = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                              initialEntryMode: TimePickerEntryMode.input,
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                    data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                              },
                            );
                            if (result != null) setState(() => endTime = result);
                          } else {
                            setState(() => endTime = null);
                          }
                        },
                        child: CategoryChip(
                          gradient: endTime == null ? AppGradients.slave : AppGradients.main,
                          textColor: endTime == null ? AppColors.text : AppColors.textOnColors,
                          childText: endTime == null ? "Выбрать время конца" : "до ${endTime!.hour}:${endTime!.minute}",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const AppTitle("Метро"),
                const SizedBox(height: 8),
                SizedBox(
                  width: mediaQuery.size.width,
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TouchableOpacity(
                        onPressed: () async {
                          await showDialog(
                            context: context,
                            builder: (ctx) {
                              return MetroMultiselect(
                                allMetroStations: MetroStations.getAllMetroStations(),
                                selectedMetroStations: metroStations,
                                onConfirmSelect: (selectedStations) {
                                  setState(() => metroStations = selectedStations);
                                },
                              );
                            },
                          );
                        },
                        child: const CategoryChip(
                          gradient: AppGradients.slave,
                          textColor: AppColors.text,
                          childText: "Выбрать ближайшие станции метро",
                        ),
                      ),
                      for (final metro in metroStations)
                        TouchableOpacity(
                          onPressed: () async {
                            setState(() => metroStations.removeWhere((element) => element.id == metro.id));
                          },
                          child: CategoryChip(
                            backgroundColor: StaticMethods.getColorByMetroLine(metro.line),
                            textColor: AppColors.textOnColors,
                            childText: metro.title,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // выбор главной категории
                BlocBuilder<CategoriesBloc, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesStateLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppTitle("Категории"),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (final cat in state.categories)
                                TouchableOpacity(
                                  onPressed: () {
                                    if (pickedCategories.contains(cat)) {
                                      pickedCategories.remove(cat);
                                    } else {
                                      pickedCategories.add(cat);
                                    }
                                    setState(() {});

                                    context.read<SubcategoriesBloc>().add(SubcategoriesEventLoad(
                                        parentCategoryIds: pickedCategories.map((parentCat) => parentCat.id).toList()));
                                  },
                                  child: CategoryChip(
                                    childText: cat.name,
                                    gradient: pickedCategories.contains(cat) ? AppGradients.main : AppGradients.first,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 24),

                // выбор подкатегорий
                if (pickedCategories.isNotEmpty)
                  BlocBuilder<SubcategoriesBloc, SubcategoriesState>(
                    builder: (context, state) {
                      if (state is SubcategoriesStateLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppTitle("Подкатегории"),
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
                                        pickedSubcategories.add(cat);
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
                      return const SizedBox.shrink();
                    },
                  ),
                const SizedBox(height: 24),
                LongButton(
                  onTap: () {
                    if (startTime != null && endTime == null) {
                      BotToast.showText(text: "Вы не выбрали верхнюю границу времени");
                      return;
                    }
                    if (startTime == null && endTime != null) {
                      BotToast.showText(text: "Вы не выбрали нижнюю границу времени");
                      return;
                    }
                    feedFiltersBloc.add(
                      SetFeedFiltersEvent(
                        filters: {
                          "time": (startTime != null && endTime != null)
                              ? TimeFilter(timeRange: TimeRange(start: startTime!, end: endTime!))
                              : null,
                          "date": dateRange != null ? DateFilter(dateRange: dateRange!) : null,
                          "metro": metroStations.isNotEmpty
                              ? NearestMetroFilter(selectedMetroStations: metroStations)
                              : null,
                          "categories": pickedCategories.isNotEmpty
                              ? CategoriesFilter(
                                  selectedCategories: pickedCategories, selectedSubcategories: pickedSubcategories)
                              : null,
                        },
                      ),
                    );
                    Navigator.of(context).pop();
                  },
                  backgroundGradient: AppGradients.main,
                  child: const Text("Применить", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
