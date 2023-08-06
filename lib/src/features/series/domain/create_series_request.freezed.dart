// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_series_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreateSeriesRequest _$CreateSeriesRequestFromJson(Map<String, dynamic> json) {
  return _CreateSeriesRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateSeriesRequest {
  DateTime get startdate => throw _privateConstructorUsedError;
  DateTime get enddate =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @JsonKey(name: 'roomId')
  int get floorDistributionId => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get cronPattern => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateSeriesRequestCopyWith<CreateSeriesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateSeriesRequestCopyWith<$Res> {
  factory $CreateSeriesRequestCopyWith(
          CreateSeriesRequest value, $Res Function(CreateSeriesRequest) then) =
      _$CreateSeriesRequestCopyWithImpl<$Res, CreateSeriesRequest>;
  @useResult
  $Res call(
      {DateTime startdate,
      DateTime enddate,
      @JsonKey(name: 'roomId') int floorDistributionId,
      String email,
      String cronPattern});
}

/// @nodoc
class _$CreateSeriesRequestCopyWithImpl<$Res, $Val extends CreateSeriesRequest>
    implements $CreateSeriesRequestCopyWith<$Res> {
  _$CreateSeriesRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startdate = null,
    Object? enddate = null,
    Object? floorDistributionId = null,
    Object? email = null,
    Object? cronPattern = null,
  }) {
    return _then(_value.copyWith(
      startdate: null == startdate
          ? _value.startdate
          : startdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      enddate: null == enddate
          ? _value.enddate
          : enddate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      floorDistributionId: null == floorDistributionId
          ? _value.floorDistributionId
          : floorDistributionId // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      cronPattern: null == cronPattern
          ? _value.cronPattern
          : cronPattern // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CreateSeriesRequestCopyWith<$Res>
    implements $CreateSeriesRequestCopyWith<$Res> {
  factory _$$_CreateSeriesRequestCopyWith(_$_CreateSeriesRequest value,
          $Res Function(_$_CreateSeriesRequest) then) =
      __$$_CreateSeriesRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime startdate,
      DateTime enddate,
      @JsonKey(name: 'roomId') int floorDistributionId,
      String email,
      String cronPattern});
}

/// @nodoc
class __$$_CreateSeriesRequestCopyWithImpl<$Res>
    extends _$CreateSeriesRequestCopyWithImpl<$Res, _$_CreateSeriesRequest>
    implements _$$_CreateSeriesRequestCopyWith<$Res> {
  __$$_CreateSeriesRequestCopyWithImpl(_$_CreateSeriesRequest _value,
      $Res Function(_$_CreateSeriesRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startdate = null,
    Object? enddate = null,
    Object? floorDistributionId = null,
    Object? email = null,
    Object? cronPattern = null,
  }) {
    return _then(_$_CreateSeriesRequest(
      startdate: null == startdate
          ? _value.startdate
          : startdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      enddate: null == enddate
          ? _value.enddate
          : enddate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      floorDistributionId: null == floorDistributionId
          ? _value.floorDistributionId
          : floorDistributionId // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      cronPattern: null == cronPattern
          ? _value.cronPattern
          : cronPattern // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreateSeriesRequest implements _CreateSeriesRequest {
  _$_CreateSeriesRequest(
      {required this.startdate,
      required this.enddate,
      @JsonKey(name: 'roomId') required this.floorDistributionId,
      required this.email,
      required this.cronPattern});

  factory _$_CreateSeriesRequest.fromJson(Map<String, dynamic> json) =>
      _$$_CreateSeriesRequestFromJson(json);

  @override
  final DateTime startdate;
  @override
  final DateTime enddate;
// ignore: invalid_annotation_target
  @override
  @JsonKey(name: 'roomId')
  final int floorDistributionId;
  @override
  final String email;
  @override
  final String cronPattern;

  @override
  String toString() {
    return 'CreateSeriesRequest(startdate: $startdate, enddate: $enddate, floorDistributionId: $floorDistributionId, email: $email, cronPattern: $cronPattern)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreateSeriesRequest &&
            (identical(other.startdate, startdate) ||
                other.startdate == startdate) &&
            (identical(other.enddate, enddate) || other.enddate == enddate) &&
            (identical(other.floorDistributionId, floorDistributionId) ||
                other.floorDistributionId == floorDistributionId) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.cronPattern, cronPattern) ||
                other.cronPattern == cronPattern));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, startdate, enddate, floorDistributionId, email, cronPattern);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreateSeriesRequestCopyWith<_$_CreateSeriesRequest> get copyWith =>
      __$$_CreateSeriesRequestCopyWithImpl<_$_CreateSeriesRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreateSeriesRequestToJson(
      this,
    );
  }
}

abstract class _CreateSeriesRequest implements CreateSeriesRequest {
  factory _CreateSeriesRequest(
      {required final DateTime startdate,
      required final DateTime enddate,
      @JsonKey(name: 'roomId') required final int floorDistributionId,
      required final String email,
      required final String cronPattern}) = _$_CreateSeriesRequest;

  factory _CreateSeriesRequest.fromJson(Map<String, dynamic> json) =
      _$_CreateSeriesRequest.fromJson;

  @override
  DateTime get startdate;
  @override
  DateTime get enddate;
  @override // ignore: invalid_annotation_target
  @JsonKey(name: 'roomId')
  int get floorDistributionId;
  @override
  String get email;
  @override
  String get cronPattern;
  @override
  @JsonKey(ignore: true)
  _$$_CreateSeriesRequestCopyWith<_$_CreateSeriesRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
