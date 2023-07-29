// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Location _$$_LocationFromJson(Map<String, dynamic> json) => _$_Location(
      id: json['id'] as int,
      zip: json['zip'] as int,
      adress: json['adress'] as String,
      city: json['city'] as String,
      name: json['name'] as String,
      main: const IntToBoolConverter().fromJson(json['main'] as int),
    );

Map<String, dynamic> _$$_LocationToJson(_$_Location instance) =>
    <String, dynamic>{
      'id': instance.id,
      'zip': instance.zip,
      'adress': instance.adress,
      'city': instance.city,
      'name': instance.name,
      'main': const IntToBoolConverter().toJson(instance.main),
    };
