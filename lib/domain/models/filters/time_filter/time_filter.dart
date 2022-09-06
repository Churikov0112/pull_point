part of '../../models.dart';

class TimeRange {
  final TimeOfDay start;
  final TimeOfDay end;

  TimeRange({
    required this.start,
    required this.end,
  });
}

class TimeFilter extends AbstractFilter {
  TimeRange timeRange;

  TimeFilter({
    required this.timeRange,
  }) : super();
}
