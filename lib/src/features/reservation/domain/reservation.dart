import 'package:freezed_annotation/freezed_annotation.dart';

import '../../series/domain/series.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';
@freezed
class Reservation with _$Reservation {
  const Reservation._();
  factory Reservation({
  required String email,
  required int roomId,
    int? id,
  required DateTime startdate,
  required DateTime enddate,
    Series? seriesObject,
  }) = _Reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  get initials {
    var splittedByDot = this.email.split('.');
    var prename = splittedByDot[0];
    var splittedByDotSplittedByAt = splittedByDot[1].split('@');
    var surname = splittedByDotSplittedByAt[0];
    return prename[0].toUpperCase() + surname[0].toUpperCase();
  }
}