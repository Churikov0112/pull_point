import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pull_point/presentation/map/blocs/blocs.dart';
import 'package:time_range_picker/time_range_picker.dart';

import '../../../../../domain/domain.dart';

class MapFiltersScreen extends StatefulWidget {
  const MapFiltersScreen({Key? key}) : super(key: key);

  @override
  State<MapFiltersScreen> createState() => _MapFiltersScreenState();
}

class _MapFiltersScreenState extends State<MapFiltersScreen> {
  late MapFiltersBloc mapFiltersBloc;

  DateTimeRange? date;
  TimeRange? time;

  @override
  void initState() {
    mapFiltersBloc = context.read<MapFiltersBloc>();
    if (mapFiltersBloc.state is MapFiltersFilteredState) {
      MapFiltersFilteredState state = mapFiltersBloc.state as MapFiltersFilteredState;
      date = state.dateTimeFilter.dateRange;
      time = state.dateTimeFilter.timeRange;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Фильтры")),
      body: BlocBuilder<MapFiltersBloc, MapFiltersState>(builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final result = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 7)),
                      );
                      if (result != null) {
                        setState(() {
                          date = result;
                        });
                        mapFiltersBloc.add(
                          SetMapFiltersEvent(
                            filters: [
                              DateTimeFilter(dateRange: date, timeRange: time),
                            ],
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                  ),
                  if (date != null)
                    Text("с ${date!.start.day}.${date!.start.month} до ${date!.end.day}.${date!.end.month}"),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      final TimeRange? result = await showTimeRangePicker(context: context);
                      if (result != null) {
                        setState(() {
                          time = result;
                        });
                        mapFiltersBloc.add(
                          SetMapFiltersEvent(
                            filters: [
                              DateTimeFilter(dateRange: date, timeRange: time),
                            ],
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.watch),
                  ),
                  if (time != null)
                    Text(
                        "с ${time!.startTime.hour}:${time!.startTime.minute} до ${time!.endTime.hour}:${time!.endTime.minute}"),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
