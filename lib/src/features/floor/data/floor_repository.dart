import 'dart:developer';

import 'package:beseated/src/features/floor/domain/floor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../../../shared/beseated_secured_http_client.dart';

part 'floor_repository.g.dart';


class FloorRepository {
  FloorRepository({required this.client});
  final String _baseEndpointUrl = '/floor';

  final BeSeatedSecuredHttpClient client;

  Future<List<Floor>> getFloorsByLocationId(int id) async {
    final response = await client.get('$_baseEndpointUrl/byLocationId/$id');
    final data = AppUtils.decodeJsonList(response.body);
    return data.map((f) => Floor.fromJson(f)).toList();
  }
}

@riverpod
FloorRepository floorRepository(FloorRepositoryRef ref) =>
    FloorRepository(client: BeSeatedSecuredHttpClient());