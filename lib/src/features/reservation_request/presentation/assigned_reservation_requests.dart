import 'dart:async';

import 'package:beseated/src/features/reservation_request/application/reservation_request_service.dart';
import 'package:beseated/src/features/reservation_request/domain/reservation_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'assigned_reservation_requests.g.dart';

@riverpod
class AssignedReservationRequests extends _$AssignedReservationRequests {

  Timer? _timer;

  @override
  List<ReservationRequest> build() {
    _getAssignedReservationRequests();
    _startReloadTimer();
    ref.onDispose(() => _timer?.cancel());
    return List.empty();
  }

  void _getAssignedReservationRequests() async {
    state = await ref.read(reservationRequestServiceProvider).getAssignedReservationRequests();
  }

  void setAssignedReservationRequestsAndResetTimer(List<ReservationRequest> reservationRequests) {
    state = reservationRequests;
    _startReloadTimer();
  }

  void _startReloadTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      _getAssignedReservationRequests();
    });
  }
}