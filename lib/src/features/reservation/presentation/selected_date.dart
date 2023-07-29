import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_date.g.dart';

@riverpod
class SelectedDate extends _$SelectedDate {
  @override
  DateTime build() {
    final now = DateTime.now();
    return now.subtract(Duration(hours: now.hour, minutes: now.minute, seconds: now.second, milliseconds: now.millisecond, microseconds: now.microsecond));
  }

  change(DateTime date) {
    state = date;
  }
}