import 'package:beseated/src/shared/app_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../series/domain/series.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';
@freezed
class Reservation with _$Reservation {
  const Reservation._();
  factory Reservation({
  required String email,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'roomId') required int floorDistributionId,
    int? id,
  required DateTime startdate,
  required DateTime enddate,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'seriesObject') Series? series,
  }) = _Reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

  String get initials {
    var splittedBySpace = fullName.split(' ');
    return splittedBySpace[0][0] + splittedBySpace[1][0];
  }

  String get fullName {
    var splittedByDot = this.email.split('.');
    var prename = splittedByDot[0];
    var splittedByDotSplittedByAt = splittedByDot[1].split('@');
    var surname = splittedByDotSplittedByAt[0];
    prename = prename.capitalize();
    surname = surname.capitalize();
    return "$prename $surname";
  }
}