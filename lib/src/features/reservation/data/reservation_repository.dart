import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../../../shared/beseated_secured_http_client.dart';
import '../domain/reservation.dart';

part 'reservation_repository.g.dart';


class ReservationRepository {
  ReservationRepository({required this.client});
  final String _baseEndpointUrl = '/reservation';

  final BeSeatedSecuredHttpClient client;

  Future<List<Reservation>> getReservationsByDate({required DateTime date}) async {
    final response = await client.get('$_baseEndpointUrl/byDate/${date.year}/${date.month}/${date.day}');
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((f) => Reservation.fromJson(f)).toList();
  }
  
  Future postReservation({required Reservation reservation}) {
    return client.post('$_baseEndpointUrl/insert', reservation.toJson(), bodyIsJson: true);
  }

  Future putReservation({required Reservation reservation}) {
    return client.post('$_baseEndpointUrl/update', reservation.toJson(), bodyIsJson: true);
  }

  Future deleteReservation({required int id}) {
    return client.delete('$_baseEndpointUrl/delete/$id');
  }


}

@riverpod
ReservationRepository reservationRepository(ReservationRepositoryRef ref) =>
    ReservationRepository(client: BeSeatedSecuredHttpClient());