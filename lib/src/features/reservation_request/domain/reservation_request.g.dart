// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ReservationRequest _$$_ReservationRequestFromJson(
        Map<String, dynamic> json) =>
    _$_ReservationRequest(
      email: json['email'] as String,
      roomId: json['roomId'] as int,
      id: json['id'] as int?,
      startdate: DateTime.parse(json['startdate'] as String),
      enddate: DateTime.parse(json['enddate'] as String),
    );

Map<String, dynamic> _$$_ReservationRequestToJson(
        _$_ReservationRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'roomId': instance.roomId,
      'id': instance.id,
      'startdate': instance.startdate.toIso8601String(),
      'enddate': instance.enddate.toIso8601String(),
    };
