import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_request.freezed.dart';
part 'reservation_request.g.dart';

@freezed
class ReservationRequest with _$ReservationRequest {
  const ReservationRequest._();
  factory ReservationRequest({
  required String email,
  required int roomId,
    int? id,
  required DateTime startdate,
  required DateTime enddate,
  }) = _ReservationRequest;

  factory ReservationRequest.fromJson(Map<String, dynamic> json) => _$ReservationRequestFromJson(json);

  get initials {
    var splittedByDot = this.email.split('.');
    var prename = splittedByDot[0];
    var splittedByDotSplittedByAt = splittedByDot[1].split('@');
    var surname = splittedByDotSplittedByAt[0];
    return prename[0].toUpperCase() + surname[0].toUpperCase();
  }
}