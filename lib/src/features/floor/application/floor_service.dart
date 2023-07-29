import 'package:beseated/src/features/floor/data/floor_repository.dart';
import 'package:beseated/src/features/floor/domain/floor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'floor_service.g.dart';

class FloorService {
  FloorService({required this.floorRepository});

  final FloorRepository floorRepository;

  Future<List<Floor>> getFloorsByLocationId({required int id}) {
    return floorRepository.getFloorsByLocationId(id);
  }
}

@riverpod
FloorService floorService(FloorServiceRef ref) =>
    FloorService(
        floorRepository: ref.watch(floorRepositoryProvider)
    );

@riverpod
Future<List<Floor>> floorsByLocationId(FloorsByLocationIdRef ref, {required int id}) =>
    ref.watch(floorServiceProvider).getFloorsByLocationId(id: id);