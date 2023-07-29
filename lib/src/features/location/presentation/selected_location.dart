import 'package:beseated/src/features/location/application/location_service.dart';
import 'package:beseated/src/features/location/domain/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_location.g.dart';

@riverpod
class SelectedLocation extends _$SelectedLocation {
  @override
  FutureOr<Location?> build() {
    return ref.read(locationServiceProvider).getAllLocations().then((value) => value.firstWhere((element) => element.main));
  }

  change(Location location) {
    if(location.id != state.value?.id) {
      state = AsyncValue.data(location);
    }
  }
}