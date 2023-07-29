import 'package:beseated/src/features/location/data/location_repository.dart';
import 'package:beseated/src/features/location/domain/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

class LocationService {
  LocationService({required this.locationRepository});

  final LocationRepository locationRepository;

  Future<List<Location>> getAllLocations() {
    return locationRepository.getAllLocations();
  }
}

@riverpod
LocationService locationService(LocationServiceRef ref) =>
    LocationService(
        locationRepository: ref.watch(locationRepositoryProvider)
    );

@riverpod
Future<List<Location>> allLocations(AllLocationsRef ref) =>
    ref.watch(locationServiceProvider).getAllLocations();