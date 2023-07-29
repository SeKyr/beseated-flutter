import 'package:beseated/src/features/floor_distribution/data/floor_distribution_repository.dart';
import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'floor_distribution_service.g.dart';

class FloorDistributionService {

  FloorDistributionService({required this.floorDistributionRepository});

  final FloorDistributionRepository floorDistributionRepository;

  Future<List<FloorDistribution>> getFloorDistributionsByFloorId({required int id}) {
    return floorDistributionRepository.getFloorDistributionsByFloorId(floorId: id);
  }

  Future<FloorDistribution> getFloorDistributionById({required int id}) {
    return floorDistributionRepository.getFloorDistributionById(id: id);
  }
}
@riverpod
FloorDistributionService floorDistributionService(FloorDistributionServiceRef ref) =>
    FloorDistributionService(
        floorDistributionRepository: ref.watch(floorDistributionRepositoryProvider)
    );

@riverpod
Future<List<FloorDistribution>> floorDistributionsByFloorId(FloorDistributionsByFloorIdRef ref, {required int id}) =>
    ref.watch(floorDistributionServiceProvider).getFloorDistributionsByFloorId(id: id);



