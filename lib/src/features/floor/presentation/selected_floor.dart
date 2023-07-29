import 'package:beseated/src/features/floor/domain/floor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_floor.g.dart';

@riverpod
class SelectedFloor extends _$SelectedFloor {
  @override
  Floor? build() {
    return null;
  }

    change(Floor floor) {
    state = floor;
  }
}