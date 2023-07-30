import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../../../shared/internet/beseated_secured_http_client.dart';
import '../domain/reservation_request.dart';

part 'reservation_request_repository.g.dart';


class ReservationRequestRepository {
  ReservationRequestRepository({required this.client});
  final String _baseEndpointUrl = '/reservation-request';

  final BeSeatedSecuredHttpClient client;

  Future<List<ReservationRequest>> getOwnReservationRequestsByDate({required DateTime date}) async {
    final response = await client.get('$_baseEndpointUrl/requested/${date.year}/${date.month}/${date.day}');
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((f) => ReservationRequest.fromJson(f)).toList();
  }

  Future<List<ReservationRequest>> getAssignedReservationRequests() async {
    final response = await client.get('$_baseEndpointUrl/assigned');
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((f) => ReservationRequest.fromJson(f)).toList();
  }
  
  Future<ReservationRequest> postReservationRequest({required ReservationRequest reservationRequest}) async {
    final response = await client.post(_baseEndpointUrl, body: reservationRequest.toJson(), bodyIsJson: true);
    final data = AppUtils.decodeJson(response.body);
    return ReservationRequest.fromJson(data);
  }

  Future rejectReservationRequest({required int id}) {
    return client.put('$_baseEndpointUrl/$id/reject');
  }

  Future acceptReservationRequest({required int id}) {
    return client.put('$_baseEndpointUrl/$id/accept');
  }

  Future cancelReservationRequest({required int floorDistributionId, required DateTime date}) {
    return client.delete('$_baseEndpointUrl/$floorDistributionId/${date.year}/${date.month}/${date.day}');
  }


}

@riverpod
ReservationRequestRepository reservationRequestRepository(ReservationRequestRepositoryRef ref) =>
    ReservationRequestRepository(client: BeSeatedSecuredHttpClient());