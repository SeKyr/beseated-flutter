// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_series_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreateSeriesRequest _$$_CreateSeriesRequestFromJson(
        Map<String, dynamic> json) =>
    _$_CreateSeriesRequest(
      startdate: DateTime.parse(json['startdate'] as String),
      enddate: DateTime.parse(json['enddate'] as String),
      floorDistributionId: json['roomId'] as int,
      email: json['email'] as String,
      cronPattern: json['cronPattern'] as String,
    );

Map<String, dynamic> _$$_CreateSeriesRequestToJson(
        _$_CreateSeriesRequest instance) =>
    <String, dynamic>{
      'startdate': instance.startdate.toIso8601String(),
      'enddate': instance.enddate.toIso8601String(),
      'roomId': instance.floorDistributionId,
      'email': instance.email,
      'cronPattern': instance.cronPattern,
    };
