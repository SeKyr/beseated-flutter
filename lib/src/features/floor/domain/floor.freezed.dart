// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'floor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Floor _$FloorFromJson(Map<String, dynamic> json) {
  return _Floor.fromJson(json);
}

/// @nodoc
mixin _$Floor {
  int get id => throw _privateConstructorUsedError;
  int get locationId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get floor =>
      throw _privateConstructorUsedError; // ignore: invalid_annotation_target
  @IntToBoolConverter()
  @JsonKey(name: 'status')
  bool get active => throw _privateConstructorUsedError;
  @IntToBoolConverter()
  bool get main => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FloorCopyWith<Floor> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FloorCopyWith<$Res> {
  factory $FloorCopyWith(Floor value, $Res Function(Floor) then) =
      _$FloorCopyWithImpl<$Res, Floor>;
  @useResult
  $Res call(
      {int id,
      int locationId,
      String name,
      int floor,
      @IntToBoolConverter() @JsonKey(name: 'status') bool active,
      @IntToBoolConverter() bool main,
      String type});
}

/// @nodoc
class _$FloorCopyWithImpl<$Res, $Val extends Floor>
    implements $FloorCopyWith<$Res> {
  _$FloorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? locationId = null,
    Object? name = null,
    Object? floor = null,
    Object? active = null,
    Object? main = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FloorCopyWith<$Res> implements $FloorCopyWith<$Res> {
  factory _$$_FloorCopyWith(_$_Floor value, $Res Function(_$_Floor) then) =
      __$$_FloorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int locationId,
      String name,
      int floor,
      @IntToBoolConverter() @JsonKey(name: 'status') bool active,
      @IntToBoolConverter() bool main,
      String type});
}

/// @nodoc
class __$$_FloorCopyWithImpl<$Res> extends _$FloorCopyWithImpl<$Res, _$_Floor>
    implements _$$_FloorCopyWith<$Res> {
  __$$_FloorCopyWithImpl(_$_Floor _value, $Res Function(_$_Floor) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? locationId = null,
    Object? name = null,
    Object? floor = null,
    Object? active = null,
    Object? main = null,
    Object? type = null,
  }) {
    return _then(_$_Floor(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      locationId: null == locationId
          ? _value.locationId
          : locationId // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      main: null == main
          ? _value.main
          : main // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Floor implements _Floor {
  _$_Floor(
      {required this.id,
      required this.locationId,
      required this.name,
      required this.floor,
      @IntToBoolConverter() @JsonKey(name: 'status') required this.active,
      @IntToBoolConverter() required this.main,
      required this.type});

  factory _$_Floor.fromJson(Map<String, dynamic> json) =>
      _$$_FloorFromJson(json);

  @override
  final int id;
  @override
  final int locationId;
  @override
  final String name;
  @override
  final int floor;
// ignore: invalid_annotation_target
  @override
  @IntToBoolConverter()
  @JsonKey(name: 'status')
  final bool active;
  @override
  @IntToBoolConverter()
  final bool main;
  @override
  final String type;

  @override
  String toString() {
    return 'Floor(id: $id, locationId: $locationId, name: $name, floor: $floor, active: $active, main: $main, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Floor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.main, main) || other.main == main) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, locationId, name, floor, active, main, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FloorCopyWith<_$_Floor> get copyWith =>
      __$$_FloorCopyWithImpl<_$_Floor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FloorToJson(
      this,
    );
  }
}

abstract class _Floor implements Floor {
  factory _Floor(
      {required final int id,
      required final int locationId,
      required final String name,
      required final int floor,
      @IntToBoolConverter() @JsonKey(name: 'status') required final bool active,
      @IntToBoolConverter() required final bool main,
      required final String type}) = _$_Floor;

  factory _Floor.fromJson(Map<String, dynamic> json) = _$_Floor.fromJson;

  @override
  int get id;
  @override
  int get locationId;
  @override
  String get name;
  @override
  int get floor;
  @override // ignore: invalid_annotation_target
  @IntToBoolConverter()
  @JsonKey(name: 'status')
  bool get active;
  @override
  @IntToBoolConverter()
  bool get main;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_FloorCopyWith<_$_Floor> get copyWith =>
      throw _privateConstructorUsedError;
}
