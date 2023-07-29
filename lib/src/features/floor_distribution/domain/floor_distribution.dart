import 'package:beseated/src/shared/converter/int_to_bool_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'floor_distribution.freezed.dart';
part 'floor_distribution.g.dart';
@freezed
class FloorDistribution with _$FloorDistribution {
  factory FloorDistribution({
    required int id,
    required String name,
    @IntToBoolConverter() required  bool reservable,
    required int floorId,
    required String shape,
    String? notification,
    required FloorDistributionType type,
    required int width,
    required int height,
    required int x,
    required int y,
    required int z
  }) = _FloorDistribution;

  factory FloorDistribution.fromJson(Map<String, dynamic> json) => _$FloorDistributionFromJson(json);
}

enum FloorDistributionType {
  room, table, parkingLot, orientation
}