// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ReservationRequest _$ReservationRequestFromJson(Map<String, dynamic> json) {
  return _ReservationRequest.fromJson(json);
}

/// @nodoc
mixin _$ReservationRequest {
  String get email =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'roomId')
  int get floorDistributionId => throw _privateConstructorUsedError;
  int? get id => throw _privateConstructorUsedError;
  DateTime get startdate => throw _privateConstructorUsedError;
  DateTime get enddate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReservationRequestCopyWith<ReservationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationRequestCopyWith<$Res> {
  factory $ReservationRequestCopyWith(
          ReservationRequest value, $Res Function(ReservationRequest) then) =
      _$ReservationRequestCopyWithImpl<$Res, ReservationRequest>;
  @useResult
  $Res call(
      {String email,
      @JsonKey(name: 'roomId') int floorDistributionId,
      int? id,
      DateTime startdate,
      DateTime enddate});
}

/// @nodoc
class _$ReservationRequestCopyWithImpl<$Res, $Val extends ReservationRequest>
    implements $ReservationRequestCopyWith<$Res> {
  _$ReservationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? floorDistributionId = null,
    Object? id = freezed,
    Object? startdate = null,
    Object? enddate = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      floorDistributionId: null == floorDistributionId
          ? _value.floorDistributionId
          : floorDistributionId // ignore: cast_nullable_to_non_nullable
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReservationRequestCopyWith<$Res>
    implements $ReservationRequestCopyWith<$Res> {
  factory _$$_ReservationRequestCopyWith(_$_ReservationRequest value,
          $Res Function(_$_ReservationRequest) then) =
      __$$_ReservationRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String email,
      @JsonKey(name: 'roomId') int floorDistributionId,
      int? id,
      DateTime startdate,
      DateTime enddate});
}

/// @nodoc
class __$$_ReservationRequestCopyWithImpl<$Res>
    extends _$ReservationRequestCopyWithImpl<$Res, _$_ReservationRequest>
    implements _$$_ReservationRequestCopyWith<$Res> {
  __$$_ReservationRequestCopyWithImpl(
      _$_ReservationRequest _value, $Res Function(_$_ReservationRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? floorDistributionId = null,
    Object? id = freezed,
    Object? startdate = null,
    Object? enddate = null,
  }) {
    return _then(_$_ReservationRequest(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      floorDistributionId: null == floorDistributionId
          ? _value.floorDistributionId
          : floorDistributionId // ignore: cast_nullable_to_non_nullable
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReservationRequest extends _ReservationRequest {
  _$_ReservationRequest(
      {required this.email,
      @JsonKey(name: 'roomId') required this.floorDistributionId,
      this.id,
      required this.startdate,
      required this.enddate})
      : super._();

  factory _$_ReservationRequest.fromJson(Map<String, dynamic> json) =>
      _$$_ReservationRequestFromJson(json);

  @override
  final String email;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'roomId')
  final int floorDistributionId;
  @override
  final int? id;
  @override
  final DateTime startdate;
  @override
  final DateTime enddate;

  @override
  String toString() {
    return 'ReservationRequest(email: $email, floorDistributionId: $floorDistributionId, id: $id, startdate: $startdate, enddate: $enddate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReservationRequest &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.floorDistributionId, floorDistributionId) ||
                other.floorDistributionId == floorDistributionId) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startdate, startdate) ||
                other.startdate == startdate) &&
            (identical(other.enddate, enddate) || other.enddate == enddate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, email, floorDistributionId, id, startdate, enddate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReservationRequestCopyWith<_$_ReservationRequest> get copyWith =>
      __$$_ReservationRequestCopyWithImpl<_$_ReservationRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReservationRequestToJson(
      this,
    );
  }
}

abstract class _ReservationRequest extends ReservationRequest {
  factory _ReservationRequest(
      {required final String email,
      @JsonKey(name: 'roomId') required final int floorDistributionId,
      final int? id,
      required final DateTime startdate,
      required final DateTime enddate}) = _$_ReservationRequest;
  _ReservationRequest._() : super._();

  factory _ReservationRequest.fromJson(Map<String, dynamic> json) =
      _$_ReservationRequest.fromJson;

  @override
  String get email;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'roomId')
  int get floorDistributionId;
  @override
  int? get id;
  @override
  DateTime get startdate;
  @override
  DateTime get enddate;
  @override
  @JsonKey(ignore: true)
  _$$_ReservationRequestCopyWith<_$_ReservationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
