import 'package:beseated/src/features/location/domain/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../application/location_service.dart';

part 'location_selection_controller.g.dart';

@Riverpod(keepAlive: true)
class LocationSelectionController extends _$LocationSelectionController {

  @override
  FutureOr<List<Location>> build() async {
    return ref.read(locationServiceProvider).getAllLocations();
  }
}