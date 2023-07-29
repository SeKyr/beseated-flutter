import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../reservation/presentation/reservation_screen_controller.dart';
import 'floor_distribution_selected.dart';

part 'selected_floor_distribution.g.dart';

@riverpod
class SelectedFloorDistribution extends _$SelectedFloorDistribution {
  @override
  FloorDistribution? build() {}

  change(FloorDistribution floorDistribution) {
    _changeFloorDistributionSelected(state?.id, floorDistribution.id);
    state = floorDistribution;
  }

  void _changeFloorDistributionSelected(int? previous, int? next) {
    if(previous != null) {
      ref.read(floorDistributionSelectedProvider(previous).notifier).change(false);
    }
    if(next != null) {
      ref.read(floorDistributionSelectedProvider(next).notifier).change(true);
    }
  }
}