import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'floor_distribution_selected.g.dart';

@riverpod
class FloorDistributionSelected extends _$FloorDistributionSelected {
  @override
  bool build(int id) {
    return false;
  }

  change(bool selected) {
    state = selected;
  }
}