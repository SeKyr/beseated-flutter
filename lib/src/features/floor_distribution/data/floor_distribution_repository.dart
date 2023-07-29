import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:beseated/src/shared/beseated_secured_http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'floor_distribution_repository.g.dart';


class FloorDistributionRepository {

  FloorDistributionRepository({required this.client});

  final String _baseEndpointUrl = '/floor_distribution';

  final BeSeatedSecuredHttpClient client;

  Future<FloorDistribution> getFloorDistributionById({required int id}) async {
    final response = await client.get('$_baseEndpointUrl/getById/$id');
    final data = AppUtils.decodeJson(response.body);
    return FloorDistribution.fromJson(data);
  }

  Future<List<FloorDistribution>> getFloorDistributions() async {
    final response = await client.get("$_baseEndpointUrl/all");
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((f) => FloorDistribution.fromJson(f)).toList();
  }

  Future<List<FloorDistribution>> getFloorDistributionsByFloorId({required int floorId}) async {
    final response = await client.get('$_baseEndpointUrl/getByFloorId/$floorId');
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((f) => FloorDistribution.fromJson(f)).toList();
  }
}

@riverpod
FloorDistributionRepository floorDistributionRepository(FloorDistributionRepositoryRef ref) =>
    FloorDistributionRepository(client: BeSeatedSecuredHttpClient());