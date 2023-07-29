// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Floor _$$_FloorFromJson(Map<String, dynamic> json) => _$_Floor(
      id: json['id'] as int,
      locationId: json['locationId'] as int,
      name: json['name'] as String,
      floor: json['floor'] as int,
      active: const IntToBoolConverter().fromJson(json['status'] as int),
      main: const IntToBoolConverter().fromJson(json['main'] as int),
      type: json['type'] as String,
    );

Map<String, dynamic> _$$_FloorToJson(_$_Floor instance) => <String, dynamic>{
      'id': instance.id,
      'locationId': instance.locationId,
      'name': instance.name,
      'floor': instance.floor,
      'status': const IntToBoolConverter().toJson(instance.active),
      'main': const IntToBoolConverter().toJson(instance.main),
      'type': instance.type,
    };
