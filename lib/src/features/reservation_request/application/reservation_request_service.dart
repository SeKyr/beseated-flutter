import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/reservation_request_repository.dart';
import '../domain/reservation_request.dart';

part 'reservation_request_service.g.dart';

class ReservationRequestService {

  ReservationRequestService({required this.reservationRequestRepository});

  final ReservationRequestRepository reservationRequestRepository;

  Future<List<ReservationRequest>> getOwnReservationRequestsByDate({required DateTime date}) async {
    return reservationRequestRepository.getOwnReservationRequestsByDate(date: date);
  }

  Future<List<ReservationRequest>> getAssignedReservationRequests() async {
    return reservationRequestRepository.getAssignedReservationRequests();
  }

  Future postReservationRequest({required ReservationRequest reservationRequest}) {
    return reservationRequestRepository.postReservationRequest(reservationRequest: reservationRequest);
  }

  Future rejectReservationRequest({required int id}) {
    return reservationRequestRepository.rejectReservationRequest(id: id);
  }

  Future acceptReservationRequest({required int id}) {
    return reservationRequestRepository.acceptReservationRequest(id: id);
  }

  Future cancelReservationRequest({required int floorDistributionId, required DateTime date}) {
    return cancelReservationRequest(floorDistributionId: floorDistributionId, date: date);
  }
}
@riverpod
ReservationRequestService reservationRequestService(ReservationRequestServiceRef ref) =>
    ReservationRequestService(
        reservationRequestRepository: ref.watch(reservationRequestRepositoryProvider)
    );
