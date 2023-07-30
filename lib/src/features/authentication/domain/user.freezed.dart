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
  Reservation? get workingPlaceReservation =>
      throw _privateConstructorUsedError;
  FloorDistribution? get workingPlace => throw _privateConstructorUsedError;
  Reservation? get parkingLotReservation => throw _privateConstructorUsedError;
  FloorDistribution? get parkingLot => throw _privateConstructorUsedError;

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
      Reservation? workingPlaceReservation,
      FloorDistribution? workingPlace,
      Reservation? parkingLotReservation,
      FloorDistribution? parkingLot});

  $ReservationCopyWith<$Res>? get workingPlaceReservation;
  $FloorDistributionCopyWith<$Res>? get workingPlace;
  $ReservationCopyWith<$Res>? get parkingLotReservation;
  $FloorDistributionCopyWith<$Res>? get parkingLot;
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
    Object? workingPlaceReservation = freezed,
    Object? workingPlace = freezed,
    Object? parkingLotReservation = freezed,
    Object? parkingLot = freezed,
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
      workingPlaceReservation: freezed == workingPlaceReservation
          ? _value.workingPlaceReservation
          : workingPlaceReservation // ignore: cast_nullable_to_non_nullable
              as Reservation?,
      workingPlace: freezed == workingPlace
          ? _value.workingPlace
          : workingPlace // ignore: cast_nullable_to_non_nullable
              as FloorDistribution?,
      parkingLotReservation: freezed == parkingLotReservation
          ? _value.parkingLotReservation
          : parkingLotReservation // ignore: cast_nullable_to_non_nullable
              as Reservation?,
      parkingLot: freezed == parkingLot
          ? _value.parkingLot
          : parkingLot // ignore: cast_nullable_to_non_nullable
              as FloorDistribution?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationCopyWith<$Res>? get workingPlaceReservation {
    if (_value.workingPlaceReservation == null) {
      return null;
    }

    return $ReservationCopyWith<$Res>(_value.workingPlaceReservation!, (value) {
      return _then(_value.copyWith(workingPlaceReservation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FloorDistributionCopyWith<$Res>? get workingPlace {
    if (_value.workingPlace == null) {
      return null;
    }

    return $FloorDistributionCopyWith<$Res>(_value.workingPlace!, (value) {
      return _then(_value.copyWith(workingPlace: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationCopyWith<$Res>? get parkingLotReservation {
    if (_value.parkingLotReservation == null) {
      return null;
    }

    return $ReservationCopyWith<$Res>(_value.parkingLotReservation!, (value) {
      return _then(_value.copyWith(parkingLotReservation: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FloorDistributionCopyWith<$Res>? get parkingLot {
    if (_value.parkingLot == null) {
      return null;
    }

    return $FloorDistributionCopyWith<$Res>(_value.parkingLot!, (value) {
      return _then(_value.copyWith(parkingLot: value) as $Val);
    });
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
      Reservation? workingPlaceReservation,
      FloorDistribution? workingPlace,
      Reservation? parkingLotReservation,
      FloorDistribution? parkingLot});

  @override
  $ReservationCopyWith<$Res>? get workingPlaceReservation;
  @override
  $FloorDistributionCopyWith<$Res>? get workingPlace;
  @override
  $ReservationCopyWith<$Res>? get parkingLotReservation;
  @override
  $FloorDistributionCopyWith<$Res>? get parkingLot;
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
    Object? workingPlaceReservation = freezed,
    Object? workingPlace = freezed,
    Object? parkingLotReservation = freezed,
    Object? parkingLot = freezed,
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
      workingPlaceReservation: freezed == workingPlaceReservation
          ? _value.workingPlaceReservation
          : workingPlaceReservation // ignore: cast_nullable_to_non_nullable
              as Reservation?,
      workingPlace: freezed == workingPlace
          ? _value.workingPlace
          : workingPlace // ignore: cast_nullable_to_non_nullable
              as FloorDistribution?,
      parkingLotReservation: freezed == parkingLotReservation
          ? _value.parkingLotReservation
          : parkingLotReservation // ignore: cast_nullable_to_non_nullable
              as Reservation?,
      parkingLot: freezed == parkingLot
          ? _value.parkingLot
          : parkingLot // ignore: cast_nullable_to_non_nullable
              as FloorDistribution?,
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
      this.workingPlaceReservation,
      this.workingPlace,
      this.parkingLotReservation,
      this.parkingLot})
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
  final Reservation? workingPlaceReservation;
  @override
  final FloorDistribution? workingPlace;
  @override
  final Reservation? parkingLotReservation;
  @override
  final FloorDistribution? parkingLot;

  @override
  String toString() {
    return 'User(surname: $surname, firstName: $firstName, email: $email, image: $image, organizationLogo: $organizationLogo, workingPlaceReservation: $workingPlaceReservation, workingPlace: $workingPlace, parkingLotReservation: $parkingLotReservation, parkingLot: $parkingLot)';
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
            (identical(
                    other.workingPlaceReservation, workingPlaceReservation) ||
                other.workingPlaceReservation == workingPlaceReservation) &&
            (identical(other.workingPlace, workingPlace) ||
                other.workingPlace == workingPlace) &&
            (identical(other.parkingLotReservation, parkingLotReservation) ||
                other.parkingLotReservation == parkingLotReservation) &&
            (identical(other.parkingLot, parkingLot) ||
                other.parkingLot == parkingLot));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      surname,
      firstName,
      email,
      image,
      organizationLogo,
      workingPlaceReservation,
      workingPlace,
      parkingLotReservation,
      parkingLot);

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
      final Reservation? workingPlaceReservation,
      final FloorDistribution? workingPlace,
      final Reservation? parkingLotReservation,
      final FloorDistribution? parkingLot}) = _$_User;
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
  Reservation? get workingPlaceReservation;
  @override
  FloorDistribution? get workingPlace;
  @override
  Reservation? get parkingLotReservation;
  @override
  FloorDistribution? get parkingLot;
  @override
  @JsonKey(ignore: true)
  _$$_UserCopyWith<_$_User> get copyWith => throw _privateConstructorUsedError;
}
