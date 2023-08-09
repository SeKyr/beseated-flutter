import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/features/floor_distribution/presentation/floor_distribution_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../reservation/domain/reservation.dart';
import '../../reservation_request/domain/reservation_request.dart';
import '../domain/floor_distribution.dart';

class ProvidableFloorDistributionUI extends ConsumerWidget {
  const ProvidableFloorDistributionUI({
    super.key,
    required this.floorDistribution,
    required this.reservationProvider,
    required this.reservationRequestProvider,
    required this.loggedInUserProvider,
    this.onTap,
    this.onDoubleTap
  });

  final FloorDistribution floorDistribution;

  final ProviderListenable<Reservation?> reservationProvider;

  final ProviderListenable<ReservationRequest?> reservationRequestProvider;

  final ProviderListenable<User?> loggedInUserProvider;

  final Function? onTap;

  final Function? onDoubleTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservation =
    ref.watch(reservationProvider);
    final reservationRequest = ref.watch(reservationRequestProvider);
    final loggedInUser = ref.read(loggedInUserProvider)!;
    return FloorDistributionUI(floorDistribution: floorDistribution,
      loggedInUserEmail: loggedInUser.email,
      reservation: reservation,
      reservationRequest: reservationRequest,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
    );
  }

}