// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Reservation _$$_ReservationFromJson(Map<String, dynamic> json) =>
    _$_Reservation(
      email: json['email'] as String,
      roomId: json['roomId'] as int,
      id: json['id'] as int?,
      startdate: DateTime.parse(json['startdate'] as String),
      enddate: DateTime.parse(json['enddate'] as String),
      seriesObject: json['seriesObject'] == null
          ? null
          : Series.fromJson(json['seriesObject'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ReservationToJson(_$_Reservation instance) =>
    <String, dynamic>{
      'email': instance.email,
      'roomId': instance.roomId,
      'id': instance.id,
      'startdate': instance.startdate.toIso8601String(),
      'enddate': instance.enddate.toIso8601String(),
      'seriesObject': instance.seriesObject,
    };
