// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_distribution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FloorDistribution _$$_FloorDistributionFromJson(Map<String, dynamic> json) =>
    _$_FloorDistribution(
      id: json['id'] as int,
      name: json['name'] as String,
      reservable:
          const IntToBoolConverter().fromJson(json['reservable'] as int),
      floorId: json['floorId'] as int,
      shape: json['shape'] as String,
      notification: json['notification'] as String?,
      type: $enumDecode(_$FloorDistributionTypeEnumMap, json['type']),
      width: json['width'] as int,
      height: json['height'] as int,
      x: json['x'] as int,
      y: json['y'] as int,
      z: json['z'] as int,
      owner: json['owner'] as String?,
    );

Map<String, dynamic> _$$_FloorDistributionToJson(
        _$_FloorDistribution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'reservable': const IntToBoolConverter().toJson(instance.reservable),
      'floorId': instance.floorId,
      'shape': instance.shape,
      'notification': instance.notification,
      'type': _$FloorDistributionTypeEnumMap[instance.type]!,
      'width': instance.width,
      'height': instance.height,
      'x': instance.x,
      'y': instance.y,
      'z': instance.z,
      'owner': instance.owner,
    };

const _$FloorDistributionTypeEnumMap = {
  FloorDistributionType.room: 'room',
  FloorDistributionType.table: 'table',
  FloorDistributionType.parkingLot: 'parkingLot',
  FloorDistributionType.orientation: 'orientation',
};
