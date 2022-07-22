part of '../models.dart';

class DateTimeFilter {
  final DateTime from;
  final DateTime until;

  const DateTimeFilter({
    required this.from,
    required this.until,
  });
}
