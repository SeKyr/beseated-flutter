import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/reservation_request/domain/reservation_request.dart';

import '../../authentication/domain/user.dart';
import '../domain/reservation.dart';

enum FloorDistributionReservationState {
  reservable, requestable, foreignReservation, ownReservation, ownReservationRequest, reservableButOwnReservationOnAnother, requestableButOwnReservationOnAnother;

  static FloorDistributionReservationState evaluateState(
      {required FloorDistribution floorDistribution,
      required User user,
      Reservation? reservation,
      ReservationRequest? request}) {
    if (reservation != null) {
      if (reservation.email.toLowerCase() == user.email.toLowerCase()) {
        return FloorDistributionReservationState.ownReservation;
      } else {
        return FloorDistributionReservationState.foreignReservation;
      }
    } else if (request != null) {
      return FloorDistributionReservationState.ownReservationRequest;
    } else {
      var userReservationByFloorDistributionType =
      user.getReservationByFloorDistributionType(floorDistribution.type);
      if (floorDistribution.owner != null && floorDistribution.owner!.toLowerCase() != user.email.toLowerCase()) {
        if (userReservationByFloorDistributionType == null) {
          return FloorDistributionReservationState.requestable;
        } else {
          return FloorDistributionReservationState.requestableButOwnReservationOnAnother;
        }
      } else {
        if (userReservationByFloorDistributionType == null) {
          return FloorDistributionReservationState.reservable;
        } else {
          return FloorDistributionReservationState.reservableButOwnReservationOnAnother;
        }
      }
    }
  }
}