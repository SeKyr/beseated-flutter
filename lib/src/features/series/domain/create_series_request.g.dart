// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_series_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreateSeriesRequest _$$_CreateSeriesRequestFromJson(
        Map<String, dynamic> json) =>
    _$_CreateSeriesRequest(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      floorDistributionId: json['roomId'] as int,
      email: json['email'] as String,
      cronPattern: json['cronPattern'] as String,
    );

Map<String, dynamic> _$$_CreateSeriesRequestToJson(
        _$_CreateSeriesRequest instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'roomId': instance.floorDistributionId,
      'email': instance.email,
      'cronPattern': instance.cronPattern,
    };
