import 'package:beseated/src/features/reservation_request/domain/reservation_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'reservation_request_by_floor_distibution.g.dart';

@Riverpod(keepAlive: true)
class ReservationRequestByFloorDistribution extends _$ReservationRequestByFloorDistribution {
  @override
  ReservationRequest? build(int id) {
  }

  change(ReservationRequest? reservation) {
    state = reservation;
  }

  @override
  bool updateShouldNotify(ReservationRequest? previous, ReservationRequest? next) {
    return (previous == null && next != null) || (previous != null && next == null);
  }
}