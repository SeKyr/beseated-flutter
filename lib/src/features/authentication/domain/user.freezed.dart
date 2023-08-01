// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$User {
  String get surname => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get organizationLogo => throw _privateConstructorUsedError;
  ReservationAndFloorDistribution?
      get workingPlaceReservationAndFloorDistribution =>
          throw _privateConstructorUsedError;
  ReservationAndFloorDistribution?
      get parkingLotReservationAndFloorDistribution =>
          throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String surname,
      String firstName,
      String email,
      String? image,
      String? organizationLogo,
      ReservationAndFloorDistribution?
          workingPlaceReservationAndFloorDistribution,
      ReservationAndFloorDistribution?
          parkingLotReservationAndFloorDistribution});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surname = null,
    Object? firstName = null,
    Object? email = null,
    Object? image = freezed,
    Object? organizationLogo = freezed,
    Object? workingPlaceReservationAndFloorDistribution = freezed,
    Object? parkingLotReservationAndFloorDistribution = freezed,
  }) {
    return _then(_value.copyWith(
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationLogo: freezed == organizationLogo
          ? _value.organizationLogo
          : organizationLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      workingPlaceReservationAndFloorDistribution: freezed ==
              workingPlaceReservationAndFloorDistribution
          ? _value.workingPlaceReservationAndFloorDistribution
          : workingPlaceReservationAndFloorDistribution // ignore: cast_nullable_to_non_nullable
              as ReservationAndFloorDistribution?,
      parkingLotReservationAndFloorDistribution: freezed ==
              parkingLotReservationAndFloorDistribution
          ? _value.parkingLotReservationAndFloorDistribution
          : parkingLotReservationAndFloorDistribution // ignore: cast_nullable_to_non_nullable
              as ReservationAndFloorDistribution?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$_UserCopyWith(_$_User value, $Res Function(_$_User) then) =
      __$$_UserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String surname,
      String firstName,
      String email,
      String? image,
      String? organizationLogo,
      ReservationAndFloorDistribution?
          workingPlaceReservationAndFloorDistribution,
      ReservationAndFloorDistribution?
          parkingLotReservationAndFloorDistribution});
}

/// @nodoc
class __$$_UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res, _$_User>
    implements _$$_UserCopyWith<$Res> {
  __$$_UserCopyWithImpl(_$_User _value, $Res Function(_$_User) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? surname = null,
    Object? firstName = null,
    Object? email = null,
    Object? image = freezed,
    Object? organizationLogo = freezed,
    Object? workingPlaceReservationAndFloorDistribution = freezed,
    Object? parkingLotReservationAndFloorDistribution = freezed,
  }) {
    return _then(_$_User(
      surname: null == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      organizationLogo: freezed == organizationLogo
          ? _value.organizationLogo
          : organizationLogo // ignore: cast_nullable_to_non_nullable
              as String?,
      workingPlaceReservationAndFloorDistribution: freezed ==
              workingPlaceReservationAndFloorDistribution
          ? _value.workingPlaceReservationAndFloorDistribution
          : workingPlaceReservationAndFloorDistribution // ignore: cast_nullable_to_non_nullable
              as ReservationAndFloorDistribution?,
      parkingLotReservationAndFloorDistribution: freezed ==
              parkingLotReservationAndFloorDistribution
          ? _value.parkingLotReservationAndFloorDistribution
          : parkingLotReservationAndFloorDistribution // ignore: cast_nullable_to_non_nullable
              as ReservationAndFloorDistribution?,
    ));
  }
}

/// @nodoc

class _$_User extends _User {
  _$_User(
      {required this.surname,
      required this.firstName,
      required this.email,
      this.image,
      this.organizationLogo,
      this.workingPlaceReservationAndFloorDistribution,
      this.parkingLotReservationAndFloorDistribution})
      : super._();

  @override
  final String surname;
  @override
  final String firstName;
  @override
  final String email;
  @override
  final String? image;
  @override
  final String? organizationLogo;
  @override
  final ReservationAndFloorDistribution?
      workingPlaceReservationAndFloorDistribution;
  @override
  final ReservationAndFloorDistribution?
      parkingLotReservationAndFloorDistribution;

  @override
  String toString() {
    return 'User(surname: $surname, firstName: $firstName, email: $email, image: $image, organizationLogo: $organizationLogo, workingPlaceReservationAndFloorDistribution: $workingPlaceReservationAndFloorDistribution, parkingLotReservationAndFloorDistribution: $parkingLotReservationAndFloorDistribution)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_User &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.organizationLogo, organizationLogo) ||
                other.organizationLogo == organizationLogo) &&
            (identical(other.workingPlaceReservationAndFloorDistribution,
                    workingPlaceReservationAndFloorDistribution) ||
                other.workingPlaceReservationAndFloorDistribution ==
                    workingPlaceReservationAndFloorDistribution) &&
            (identical(other.parkingLotReservationAndFloorDistribution,
                    parkingLotReservationAndFloorDistribution) ||
                other.parkingLotReservationAndFloorDistribution ==
                    parkingLotReservationAndFloorDistribution));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      surname,
      firstName,
      email,
      image,
      organizationLogo,
      workingPlaceReservationAndFloorDistribution,
      parkingLotReservationAndFloorDistribution);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserCopyWith<_$_User> get copyWith =>
      __$$_UserCopyWithImpl<_$_User>(this, _$identity);
}

abstract class _User extends User {
  factory _User(
      {required final String surname,
      required final String firstName,
      required final String email,
      final String? image,
      final String? organizationLogo,
      final ReservationAndFloorDistribution?
          workingPlaceReservationAndFloorDistribution,
      final ReservationAndFloorDistribution?
          parkingLotReservationAndFloorDistribution}) = _$_User;
  _User._() : super._();

  @override
  String get surname;
  @override
  String get firstName;
  @override
  String get email;
  @override
  String? get image;
  @override
  String? get organizationLogo;
  @override
  ReservationAndFloorDistribution?
      get workingPlaceReservationAndFloorDistribution;
  @override
  ReservationAndFloorDistribution?
      get parkingLotReservationAndFloorDistribution;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
