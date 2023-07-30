import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/reservation_request/domain/reservation_request.dart';

import '../../authentication/domain/user.dart';
import '../domain/reservation.dart';

enum ReservationProcessState {
  reservable, requestable, foreignReservation, ownReservation, ownReservationRequest, reservableButOwnReservationOnAnother, requestableButOwnReservationOnAnother;

  static ReservationProcessState evaluateState(
      {required FloorDistribution floorDistribution,
      required User user,
      Reservation? reservation,
      ReservationRequest? request}) {
    if (reservation != null) {
      if (reservation.email.toLowerCase() == user.email.toLowerCase()) {
        return ReservationProcessState.ownReservation;
      } else {
        return ReservationProcessState.foreignReservation;
      }
    } else if (request != null) {
      return ReservationProcessState.ownReservationRequest;
    } else {
      var userReservationByFloorDistributionType =
      user.getReservationByFloorDistributionType(floorDistribution.type);
      if (floorDistribution.owner != null) {
        if (userReservationByFloorDistributionType == null) {
          return ReservationProcessState.requestable;
        } else {
          return ReservationProcessState.requestableButOwnReservationOnAnother;
        }
      } else {
        if (userReservationByFloorDistributionType == null) {
          return ReservationProcessState.reservable;
        } else {
          return ReservationProcessState.reservableButOwnReservationOnAnother;
        }
      }
    }
  }
}