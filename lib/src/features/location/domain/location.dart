import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../shared/converter/int_to_bool_converter.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
class Location with _$Location {
  factory Location({
    required int id,
    required int zip,
    required String adress,
    required String city,
    required String name,
    @IntToBoolConverter() required bool main,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}