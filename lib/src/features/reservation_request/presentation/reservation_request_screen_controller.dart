import 'dart:async';

import 'package:beseated/src/features/reservation_request/application/reservation_request_service.dart';
import 'package:beseated/src/features/reservation_request/domain/reservation_request.dart';
import 'package:beseated/src/features/reservation_request/presentation/assigned_reservation_requests.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../floor_distribution/application/floor_distribution_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


part 'reservation_request_screen_controller.g.dart';

class ReservationRequestWithFloorDistributionName {
  ReservationRequestWithFloorDistributionName({required this.reservationRequest, required this.floorDistributionName});
  ReservationRequest reservationRequest;
  String floorDistributionName;
}

final reservationRequestWithFloorDistributionNameProvider =
AutoDisposeStateProvider<List<ReservationRequestWithFloorDistributionName>>((ref) {
  return List.empty();
});

@riverpod
class ReservationRequestScreenController extends _$ReservationRequestScreenController {

  @override
  FutureOr<bool> build() {
    _initalizeListener();
    return false;
  }

  void _initalizeListener() {
    var reservationRequests = ref.read(assignedReservationRequestsProvider);
    Future(() => _loadFloorDistributionsForReservationRequestsAndFillProvider(reservationRequests));
    ref.listen(assignedReservationRequestsProvider, (previous, next) {
      _loadFloorDistributionsForReservationRequestsAndFillProvider(next);
    });
  }

  Future<void> _loadFloorDistributionsForReservationRequestsAndFillProvider(List<ReservationRequest> reservationRequests) async {
    state = const AsyncLoading();
    List<ReservationRequestWithFloorDistributionName> list = List.empty(growable: true);
    for (var reservationRequest in reservationRequests) {
      var floorDistribution = await ref
          .read(floorDistributionServiceProvider)
          .getFloorDistributionById(id: reservationRequest.floorDistributionId);
      list.add(ReservationRequestWithFloorDistributionName(reservationRequest: reservationRequest, floorDistributionName: floorDistribution.name));
    }
    ref.read(reservationRequestWithFloorDistributionNameProvider.notifier).state = list;
    state = const AsyncData(true);
  }

  void acceptReservationRequest(int id) {
    AppUtils.showConfirmDialog(AppLocalizations.of(navigatorKey.currentContext!)!
.requestAcceptConfirmation, () async {
      ref.read(reservationRequestServiceProvider).acceptReservationRequest(id: id).then((value) {
        AppUtils.showSuccessToast(AppLocalizations.of(navigatorKey.currentContext!)!
.reservationRequestAcceptedToast);
          reloadReservationRequestsAfterChange();
    }, onError: (_) => AppUtils.showErrorToast());
    });
  }

  void rejectReservationRequest(int id) {
    AppUtils.showConfirmDialog(AppLocalizations.of(navigatorKey.currentContext!)!
.requestRejectConfirmation, () async {
      ref.read(reservationRequestServiceProvider).rejectReservationRequest(id: id).then((value) {
      AppUtils.showSuccessToast(AppLocalizations.of(navigatorKey.currentContext!)!
.reservationRequestRejectedToast);
      reloadReservationRequestsAfterChange();
    }, onError: (_) => AppUtils.showErrorToast());
    });
  }

  void reloadReservationRequestsAfterChange() {
    // timer to reload data every 500ms
    final timer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      var reservationRequests = await ref.read(reservationRequestServiceProvider).getAssignedReservationRequests();
      ref.read(assignedReservationRequestsProvider.notifier).setAssignedReservationRequestsAndResetTimer(reservationRequests);
    });

    // cancel Timer after 5 reloads
    Timer(const Duration(milliseconds: 2500), () {
      timer.cancel();
    });
  }
}