import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_by_floor_distibution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/presentation/logged_in_user.dart';
import '../../reservation/domain/reservation.dart';
import 'floor_distribution_selected.dart';

class FloorDistributionUI extends ConsumerWidget {
  const FloorDistributionUI(
      {super.key,
      required this.floorDistribution,
      this.onDoubleTap,
      this.onTap});

  final FloorDistribution floorDistribution;

  final Function? onTap;

  final Function? onDoubleTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected =
        ref.watch(floorDistributionSelectedProvider(floorDistribution.id));
    final reservation =
        ref.watch(reservationByFloorDistributionProvider(floorDistribution.id));
    final backgroundColor = _evaluateBackgroundColor(selected, reservation, context);
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
          child: _getFloorDistributionChild(reservation, ref.read(loggedInUserProvider)!.email),
        ),
      ),
    );
  }

  Color _evaluateBackgroundColor(bool selected, Reservation? reservation, BuildContext context) {
    if (floorDistribution.reservable) {
      if (reservation != null) {
        return selected ? Colors.black12 : Colors.grey;
      } else {
        return selected ? Colors.lightBlueAccent : Theme.of(context).primaryColor;
      }
    } else {
      return Colors.white;
    }
  }

  Widget? _getFloorDistributionChild(Reservation? reservation, String userEmail) {
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
      return CircleAvatar(
        backgroundColor: reservation.email.toLowerCase() == userEmail.toLowerCase() ? const Color.fromRGBO(27, 121, 31, 100) : Colors.black,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            reservation.initials,
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
      );
    }
    return null;
  }
}
