import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class SeriesDescription {
  SeriesDescription({required this.type, this.weekdays = const [], required this.until});
  SeriesType type;
  List<int> weekdays;
  DateTime until;

  get cronPattern {
    if (type == SeriesType.daily) {
      return 'Montag_Dienstag_Mittwoch_Donnerstag_Freitag_';
    } else if (type == SeriesType.weekly) {
      var weekdaysMap = _createWeekdaysMap();
      return weekdays.map((w) => weekdaysMap[w]).join('_');
    }
  }

  Map<int, String> _createWeekdaysMap() {
    Map<int, String> result = {};
    var today = DateTime.now();
    var difToMonday = today.weekday - DateTime.monday;
    var monday = today.copyWith(day: today.day - difToMonday);
    for(int i = 0; i<=4; i++) {
      var weekday = monday.copyWith(day: monday.day + i);
      result[weekday.weekday] = DateFormat.EEEE('de').format(weekday);
    }
    return result;
  }
}

enum SeriesType {
  never, daily, weekly;

  String getLocalizedName(AppLocalizations localizations) {
    switch (this) {
      case SeriesType.never:
        return localizations.reservationDialogReservationRepititionNever;
      case SeriesType.daily:
        return localizations.reservationDialogReservationRepititionDaily;
      case SeriesType.weekly:
        return localizations.reservationDialogReservationRepititionWeekly;
    }
  }
}