import 'package:beseated/src/features/location/domain/location.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/beseated_secured_http_client.dart';

part 'location_repository.g.dart';

class LocationRepository {
  LocationRepository({required this.client});
  final String _baseEndpointUrl = '/location';

  final BeSeatedSecuredHttpClient client;

  Future<List<Location>> getAllLocations() async {
    final response = await client.get('$_baseEndpointUrl/all');
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((l) => Location.fromJson(l)).toList();
  }
}

@riverpod
LocationRepository locationRepository(LocationRepositoryRef ref) =>
    LocationRepository(client: BeSeatedSecuredHttpClient());