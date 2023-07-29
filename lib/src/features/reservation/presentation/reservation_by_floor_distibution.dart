import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/reservation.dart';

part 'reservation_by_floor_distibution.g.dart';

@Riverpod(keepAlive: true)
class ReservationByFloorDistribution extends _$ReservationByFloorDistribution {
  @override
  Reservation? build(int id) {
  }

  change(Reservation? reservation) {
    state = reservation;
  }

  @override
  bool updateShouldNotify(Reservation? previous, Reservation? next) {
    return !((previous == null && next == null) || (previous?.email == next?.email));
  }
}