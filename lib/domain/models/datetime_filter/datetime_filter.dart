part of '../models.dart';

// always put id to filter classes
abstract class AbstractFilter {
  late int id;

  AbstractFilter({
    required this.id,
  });
}

class DateTimeFilter extends AbstractFilter {
  DateTimeRange? dateRange;
  TimeRange? timeRange;

  DateTimeFilter({
    this.dateRange,
    this.timeRange,
  }) : super(id: 0);
}
