import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/reservation/domain/reservation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  factory User({
    required String surname,
    required String firstName,
    required String email,
    String? image,
    String? organizationLogo,
    Reservation? workingPlaceReservation,
    FloorDistribution? workingPlace,
    Reservation? parkingLotReservation,
    FloorDistribution? parkingLot,
  }) = _User;

  Reservation? getReservationByFloorDistributionType(
      FloorDistributionType type) {
    if (type == FloorDistributionType.table) {
      return workingPlaceReservation;
    } else if (type == FloorDistributionType.parkingLot) {
      return parkingLotReservation;
    }
    return null;
  }
}
