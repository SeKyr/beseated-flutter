import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting.freezed.dart';
part 'setting.g.dart';
@freezed
class Setting with _$Setting {
  const Setting._();
  factory Setting({
    required String name,
    required String value
  }) = _Setting;

  factory Setting.fromJson(Map<String, dynamic> json) => _$SettingFromJson(json);
}

class Settings {
  static const maxPeople = "maxPeople";
  static const maxParking = "maxParking";
  static const firstBorder = "1Border";
  static const secondBorder = "2Border";
  static const colorFirstStage = "color1Stage";
  static const colorSecondStage = "color2Stage";
  static const colorThirdStage = "color3Stage";
  static const rangeColor = "rangeColor";
}