import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/reservation/domain/reservation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logged_in_user.g.dart';

@Riverpod(keepAlive: true)
class LoggedInUser extends _$LoggedInUser {
  @override
  User? build() {
    return null;
  }

  change(User user) {
    state = user;
  }

  changeReservationAndFloorDistributionByType({required FloorDistributionType type, Reservation? reservation, FloorDistribution? floorDistribution}) {
    if (type == FloorDistributionType.table) {
      state = state?.copyWith(workingPlace: floorDistribution, workingPlaceReservation: reservation);
    } else if(type == FloorDistributionType.parkingLot) {
      state = state?.copyWith(parkingLot: floorDistribution, parkingLotReservation: reservation);
    }
  }
}