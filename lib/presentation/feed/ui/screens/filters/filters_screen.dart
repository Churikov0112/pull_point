import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_range_picker/time_range_picker.dart';

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

  DateTimeRange? date;
  TimeRange? time;

  @override
  void initState() {
    feedFiltersBloc = context.read<FeedFiltersBloc>();
    if (feedFiltersBloc.state is FeedFiltersFilteredState) {
      FeedFiltersFilteredState state = feedFiltersBloc.state as FeedFiltersFilteredState;
      date = state.dateTimeFilter.dateRange;
      time = state.dateTimeFilter.timeRange;
    }
    super.initState();
  }

  @override
  void deactivate() {
    feedFiltersBloc.add(SetFeedFiltersEvent(filters: [DateTimeFilter(dateRange: date, timeRange: time)]));
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Фильтры"),
        actions: [
          TouchableOpacity(
            onPressed: () {
              setState(() {
                date = null;
                time = null;
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
      body: BlocBuilder<FeedFiltersBloc, FeedFiltersState>(builder: (context, state) {
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
                      final TimeRange? result = await showTimeRangePicker(
                        context: context,
                        start: const TimeOfDay(hour: 8, minute: 0),
                        end: const TimeOfDay(hour: 23, minute: 55),
                      );
                      if (result != null) {
                        setState(() {
                          time = result;
                        });
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
