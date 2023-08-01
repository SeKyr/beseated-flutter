import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/reservation/domain/reservation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logged_in_user.g.dart';

@Riverpod(keepAlive: true)
class LoggedInUser extends _$LoggedInUser {
  int counter = 0;
  @override
  User? build() {
    return null;
  }

  void change(User user) {
    state = user;
  }

  void changeOwnReservationAndFloorDistributions(List<ReservationAndFloorDistribution> ownReservations) {
    ReservationAndFloorDistribution? parkingLot;
    ReservationAndFloorDistribution? workingPlace;
    if(ownReservations.isNotEmpty) {
      try {
        parkingLot = ownReservations.firstWhere((element) => element.floorDistribution.type == FloorDistributionType.parkingLot);
      } on StateError catch (_, error) {
        parkingLot = null;
      }
      try {
        workingPlace = ownReservations.firstWhere((element) => element.floorDistribution.type == FloorDistributionType.table);
      } on StateError catch (_, error) {
        workingPlace = null;
      }
    }
    state = state?.copyWith(workingPlaceReservationAndFloorDistribution: workingPlace, parkingLotReservationAndFloorDistribution: parkingLot);
  }

  void deleteReservationAndFloorDistributionByType(FloorDistributionType type) {
    if (type == FloorDistributionType.table) {
      if (state?.workingPlaceReservationAndFloorDistribution != null) {
        state =
            state?.copyWith(workingPlaceReservationAndFloorDistribution: null);
      }
    } else if (type == FloorDistributionType.parkingLot) {
      if (state?.parkingLotReservationAndFloorDistribution != null) {
        state =
            state?.copyWith(parkingLotReservationAndFloorDistribution: null);
      }
    }
  }

    void changeReservationAndFloorDistributionByType(ReservationAndFloorDistribution reservationAndFloorDistribution, FloorDistributionType type) {
      if (type == FloorDistributionType.table) {
        state = state?.copyWith(workingPlaceReservationAndFloorDistribution: reservationAndFloorDistribution);
      } else if (type == FloorDistributionType.parkingLot) {
        state = state?.copyWith(parkingLotReservationAndFloorDistribution: reservationAndFloorDistribution);
      }
    }
}