import 'package:beseated/src/features/series/domain/create_series_request.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../reservation/domain/reservation.dart';
import '../data/series_repository.dart';

part 'series_service.g.dart';

class SeriesService {

  SeriesService({required this.seriesRepository});

  final SeriesRepository seriesRepository;

  Future<List<Reservation>> postSeries({required CreateSeriesRequest createSeriesRequest}) {
    return seriesRepository.postSeries(createSeriesRequest: createSeriesRequest);
  }

  Future deleteSeries({required int id}) {
    return seriesRepository.deleteSeries(id: id);
  }
}
@riverpod
SeriesService seriesService(SeriesServiceRef ref) =>
    SeriesService(
        seriesRepository: ref.watch(seriesRepositoryProvider)
    );