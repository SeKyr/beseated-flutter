import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../reservation/domain/reservation.dart';
import '../../reservation_request/domain/reservation_request.dart';

class FloorDistributionUI extends ConsumerWidget {
  const FloorDistributionUI(
      {
        super.key,
        required this.floorDistribution,
        required this.loggedInUserEmail,
        this.reservation,
        this.reservationRequest,
        this.onDoubleTap,
        this.onTap
      });

  final FloorDistribution floorDistribution;

  final Reservation? reservation;

  final ReservationRequest? reservationRequest;

  final String loggedInUserEmail;

  final Function? onTap;

  final Function? onDoubleTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backgroundColor = _evaluateBackgroundColor(context);
    return Positioned(
      left: floorDistribution.x.toDouble(),
      top: floorDistribution.y.toDouble(),
      width: floorDistribution.width.toDouble(),
      height: floorDistribution.height.toDouble(),
      child: GestureDetector(
        onTap: () => onTap?.call(),
        onDoubleTap: () => onDoubleTap?.call(),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onBackground, width: 1),
              borderRadius: BorderRadius.circular(3),
              color: backgroundColor),
          child: _getFloorDistributionChild(context),
        ),
      ),
    );
  }

  Color _evaluateBackgroundColor(BuildContext context) {
    if (floorDistribution.reservable) {
      if (reservation != null) {
        bool isOwnReservation = reservation!.email.toLowerCase() == loggedInUserEmail.toLowerCase();
        if(isOwnReservation) {
          return Theme.of(context).colorScheme.secondary;
        } else {
          return Theme.of(context).colorScheme.primaryContainer;
        }
      } else if (reservationRequest != null) {
        return Theme.of(context).colorScheme.tertiary;
      } else {
        return Theme.of(context).colorScheme.primary;
      }
    } else {
      return Theme.of(context).colorScheme.background;
    }
  }

  Widget? _getFloorDistributionChild(BuildContext context) {
    if (floorDistribution.type == FloorDistributionType.room) {
      return Stack(children: [
        Positioned(
            left: 0,
            top: 0,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                floorDistribution.name,
                style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onBackground),
              ),
            ))
      ]);
    } else if (reservation != null || reservationRequest != null) {
      Color backgroundColor;
      Color textColor;
      if (reservation != null) {
        bool isOwnReservation = reservation!.email.toLowerCase() == loggedInUserEmail.toLowerCase();
        backgroundColor = isOwnReservation ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.onPrimaryContainer;
        textColor = isOwnReservation ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primaryContainer;
      } else {
        backgroundColor = Theme.of(context).colorScheme.onTertiary;
        textColor = Theme.of(context).colorScheme.tertiary;
      }
      return CircleAvatar(
        backgroundColor: backgroundColor, //const Color.fromRGBO(27, 121, 31, 100)
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            reservation?.initials ?? reservationRequest!.initials,
            style: TextStyle(fontSize: 10, color: textColor),
          ),
        ),
      );
    }
    return null;
  }
}
