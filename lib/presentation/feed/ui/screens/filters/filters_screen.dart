import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_point/data/repositories/impls/metro_stations_repository_impl.dart';

import '../../../../../domain/domain.dart';
import '../../../../ui_kit/ui_kit.dart';
import '../../../blocs/blocs.dart';

class FeedFiltersScreen extends StatefulWidget {
  const FeedFiltersScreen({Key? key}) : super(key: key);

  @override
  State<FeedFiltersScreen> createState() => _FeedFiltersScreenState();
}

class _FeedFiltersScreenState extends State<FeedFiltersScreen> {
  late FeedFiltersBloc feedFiltersBloc;

  DateTimeRange? dateRange;

  TimeOfDay? start;
  TimeOfDay? end;

  List<MetroStationModel?>? metroStations;

  @override
  void initState() {
    feedFiltersBloc = context.read<FeedFiltersBloc>();
    if (feedFiltersBloc.state is FeedFiltersFilteredState) {
      FeedFiltersFilteredState state = feedFiltersBloc.state as FeedFiltersFilteredState;
      dateRange = state.dateTimeFilter.dateRange;
      start = state.dateTimeFilter.timeRange?.start;
      end = state.dateTimeFilter.timeRange?.end;
    }
    super.initState();
  }

  // @override
  // void deactivate() {
  //   feedFiltersBloc.add(SetFeedFiltersEvent(filters: [DateTimeFilter(dateRange: dateRange, timeRange: timeRange)]));
  //   super.deactivate();
  // }

  final _items = MetroStations.getAllMetroStations().map((station) => MultiSelectItem<MetroStationModel>(station, station.title)).toList();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Фильтры"),
        actions: [
          TouchableOpacity(
            onPressed: () {
              setState(() {
                dateRange = null;
                start = null;
                end = null;
              });
            },
            child: const SizedBox(
              height: 30,
              width: 100,
              child: Center(child: Text("Сбросить")),
            ),
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
                Row(
                  children: [
                    TouchableOpacity(
                      onPressed: () async {
                        final result = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 7)),
                        );
                        if (result != null) {
                          setState(() {
                            dateRange = result;
                          });
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Дата (range)"),
                        ),
                      ),
                    ),
                    if (dateRange != null)
                      Text("с ${dateRange!.start.day}.${dateRange!.start.month} до ${dateRange!.end.day}.${dateRange!.end.month}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TouchableOpacity(
                      onPressed: () async {
                        final result = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.input,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (result != null) {
                          setState(() {
                            start = result;
                          });
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Время (start)"),
                        ),
                      ),
                    ),
                    if (start != null) Text("с ${start!.hour}:${start!.minute}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TouchableOpacity(
                      onPressed: () async {
                        final result = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          initialEntryMode: TimePickerEntryMode.input,
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                              child: child!,
                            );
                          },
                        );
                        if (result != null) {
                          setState(() {
                            end = result;
                          });
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Время (end)"),
                        ),
                      ),
                    ),
                    if (end != null) Text("до ${end!.hour}:${end!.minute}"),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    TouchableOpacity(
                      onPressed: () async {
                        var result;
                        await showDialog(
                          context: context,
                          builder: (ctx) {
                            return MultiSelectDialog(
                              items: _items,
                              initialValue: [],
                              onConfirm: (values) {
                                result = values;
                              },
                            );
                          },
                        );
                        if (result != null) {
                          if (result!.isNotEmpty) {
                            setState(() {
                              metroStations = result;
                            });
                          }
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text("Ближайшие станции метро (несколько)"),
                        ),
                      ),
                    ),
                    if (metroStations != null)
                      Column(
                        children: [
                          for (final station in metroStations!) Text(station!.title),
                        ],
                      ),
                  ],
                ),
                const SizedBox(height: 32),
                TouchableOpacity(
                  onPressed: () {
                    if (start != null && end == null) {
                      BotToast.showText(text: "Вы не выбрали верхнюю границу времени");
                      return;
                    }
                    if (start == null && end != null) {
                      BotToast.showText(text: "Вы не выбрали нижнюю границу времени");
                      return;
                    }
                    if ((start != null && end != null)) {
                      feedFiltersBloc
                          .add(SetFeedFiltersEvent(filters: [DateTimeFilter(dateRange: dateRange, timeRange: TimeRange(start: start!, end: end!))]));
                    } else {
                      feedFiltersBloc.add(SetFeedFiltersEvent(filters: [DateTimeFilter(dateRange: dateRange, timeRange: null)]));
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Center(
                        child: Text(
                          "Применить",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
