import 'dart:async';

import 'package:beseated/src/features/series/domain/create_series_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../../../shared/internet/beseated_secured_http_client.dart';
import '../../reservation/domain/reservation.dart';

part 'series_repository.g.dart';


class SeriesRepository {
  SeriesRepository({required this.client});
  final String _baseEndpointUrl = '/series';

  final BeSeatedSecuredHttpClient client;

  Future<List<Reservation>> postSeries({required CreateSeriesRequest createSeriesRequest}) async {
    final response = await client.post('$_baseEndpointUrl/createSeries', body: createSeriesRequest.toJson(), bodyIsJson: true);
    final data = AppUtils.decodeJson(response.body);
    final list = data['invalidReservations'] as List;
    return list.map((f) => Reservation.fromJson(f)).toList();
  }

  Future deleteSeries({required int id}) {
    return client.delete('$_baseEndpointUrl/delete/$id');
  }


}

@riverpod
SeriesRepository seriesRepository(SeriesRepositoryRef ref) =>
    SeriesRepository(client: BeSeatedSecuredHttpClient());