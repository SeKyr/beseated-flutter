import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../reservation/domain/reservation.dart';

class FloorDistributionUI extends ConsumerWidget {
  const FloorDistributionUI(
      {
        super.key,
        required this.floorDistribution,
        required this.selected,
        required this.loggedInUserEmail,
        this.reservation,
        this.onDoubleTap,
        this.onTap
      });

  final FloorDistribution floorDistribution;

  final bool selected;

  final Reservation? reservation;

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
              border: Border.all(color: Colors.black, width: 1),
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
          return selected ? Theme.of(context).colorScheme.secondary.withOpacity(0.5)  : Theme.of(context).colorScheme.secondary;
        } else {
          return selected ? Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5)  : Theme.of(context).colorScheme.primaryContainer;
        }
      } else {
        return selected ? Theme.of(context).colorScheme.primary.withOpacity(0.5) : Theme.of(context).colorScheme.primary;
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
                style: const TextStyle(fontSize: 10, color: Colors.black),
              ),
            ))
      ]);
    } else if (reservation != null) {
      bool isOwnReservation = reservation!.email.toLowerCase() == loggedInUserEmail.toLowerCase();
      return CircleAvatar(
        backgroundColor: isOwnReservation ? Theme.of(context).colorScheme.onSecondary : Theme.of(context).colorScheme.onPrimaryContainer, //const Color.fromRGBO(27, 121, 31, 100)
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            reservation!.initials,
            style: TextStyle(fontSize: 10, color: isOwnReservation ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primaryContainer),
          ),
        ),
      );
    }
    return null;
  }
}
