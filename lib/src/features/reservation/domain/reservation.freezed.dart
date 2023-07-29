// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Reservation _$ReservationFromJson(Map<String, dynamic> json) {
  return _Reservation.fromJson(json);
}

/// @nodoc
mixin _$Reservation {
  String get email => throw _privateConstructorUsedError;
  int get roomId => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  DateTime get startdate => throw _privateConstructorUsedError;
  DateTime get enddate => throw _privateConstructorUsedError;
  Series? get seriesObject => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {String email,
      int roomId,
      int? id,
      DateTime startdate,
      DateTime enddate,
      Series? seriesObject});

  $SeriesCopyWith<$Res>? get seriesObject;
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? roomId = null,
    Object? id = freezed,
    Object? startdate = null,
    Object? enddate = null,
    Object? seriesObject = freezed,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      startdate: null == startdate
          ? _value.startdate
          : startdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      enddate: null == enddate
          ? _value.enddate
          : enddate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      seriesObject: freezed == seriesObject
          ? _value.seriesObject
          : seriesObject // ignore: cast_nullable_to_non_nullable
              as Series?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SeriesCopyWith<$Res>? get seriesObject {
    if (_value.seriesObject == null) {
      return null;
    }

    return $SeriesCopyWith<$Res>(_value.seriesObject!, (value) {
      return _then(_value.copyWith(seriesObject: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ReservationCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$_ReservationCopyWith(
          _$_Reservation value, $Res Function(_$_Reservation) then) =
      __$$_ReservationCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      int roomId,
      int? id,
      DateTime startdate,
      DateTime enddate,
      Series? seriesObject});

  @override
  $SeriesCopyWith<$Res>? get seriesObject;
}

/// @nodoc
class __$$_ReservationCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$_Reservation>
    implements _$$_ReservationCopyWith<$Res> {
  __$$_ReservationCopyWithImpl(
      _$_Reservation _value, $Res Function(_$_Reservation) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? roomId = null,
    Object? id = freezed,
    Object? startdate = null,
    Object? enddate = null,
    Object? seriesObject = freezed,
  }) {
    return _then(_$_Reservation(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as int,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      startdate: null == startdate
          ? _value.startdate
          : startdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      enddate: null == enddate
          ? _value.enddate
          : enddate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      seriesObject: freezed == seriesObject
          ? _value.seriesObject
          : seriesObject // ignore: cast_nullable_to_non_nullable
              as Series?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Reservation extends _Reservation {
  _$_Reservation(
      {required this.email,
      required this.roomId,
      this.id,
      required this.startdate,
      required this.enddate,
      this.seriesObject})
      : super._();

  factory _$_Reservation.fromJson(Map<String, dynamic> json) =>
      _$$_ReservationFromJson(json);

  @override
  final String email;
  @override
  final int roomId;
  @override
  final int? id;
  @override
  final DateTime startdate;
  @override
  final DateTime enddate;
  @override
  final Series? seriesObject;

  @override
  String toString() {
    return 'Reservation(email: $email, roomId: $roomId, id: $id, startdate: $startdate, enddate: $enddate, seriesObject: $seriesObject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Reservation &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startdate, startdate) ||
                other.startdate == startdate) &&
            (identical(other.enddate, enddate) || other.enddate == enddate) &&
            (identical(other.seriesObject, seriesObject) ||
                other.seriesObject == seriesObject));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, roomId, id, startdate, enddate, seriesObject);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReservationCopyWith<_$_Reservation> get copyWith =>
      __$$_ReservationCopyWithImpl<_$_Reservation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReservationToJson(
      this,
    );
  }
}

abstract class _Reservation extends Reservation {
  factory _Reservation(
      {required final String email,
      required final int roomId,
      final int? id,
      required final DateTime startdate,
      required final DateTime enddate,
      final Series? seriesObject}) = _$_Reservation;
  _Reservation._() : super._();

  factory _Reservation.fromJson(Map<String, dynamic> json) =
      _$_Reservation.fromJson;

  @override
  String get email;
  @override
  int get roomId;
  @override
  int? get id;
  @override
  DateTime get startdate;
  @override
  DateTime get enddate;
  @override
  Series? get seriesObject;
  @override
  @JsonKey(ignore: true)
  _$$_ReservationCopyWith<_$_Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}
