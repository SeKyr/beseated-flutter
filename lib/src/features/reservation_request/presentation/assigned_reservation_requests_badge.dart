import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'assigned_reservation_requests.dart';
import 'package:badges/badges.dart' as badges;


class AssignedReservationRequestsBadge extends ConsumerWidget {
  const AssignedReservationRequestsBadge({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var reservationRequests = ref.watch(assignedReservationRequestsProvider);
    return badges.Badge(
        showBadge: reservationRequests.isNotEmpty,
        badgeContent: reservationRequests.isNotEmpty
            ? Text('${reservationRequests.length}', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),)
            : null,
        badgeStyle: badges.BadgeStyle(badgeColor: Theme.of(context).colorScheme.primary),
        child: child);
  }

}