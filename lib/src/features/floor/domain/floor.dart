import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/converter/int_to_bool_converter.dart';

part 'floor.freezed.dart';
part 'floor.g.dart';
@freezed
class Floor with _$Floor{
  factory Floor({
    required int id,
    required int locationId,
    required String name,
    required int floor,
    // ignore: invalid_annotation_target
    @IntToBoolConverter() @JsonKey(name: 'status') required bool active,
    @IntToBoolConverter() required bool main,
    required String type,
  }) = _Floor;

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);
}