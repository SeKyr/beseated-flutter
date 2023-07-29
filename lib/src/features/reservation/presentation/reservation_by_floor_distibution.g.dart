// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_by_floor_distibution.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

String _$ReservationByFloorDistributionHash() =>
    r'b48a45077bd0a9b2527b46f0c438f37143b27dae';

/// See also [ReservationByFloorDistribution].
class ReservationByFloorDistributionProvider
    extends NotifierProviderImpl<ReservationByFloorDistribution, Reservation?> {
  ReservationByFloorDistributionProvider(
    this.id,
  ) : super(
          () => ReservationByFloorDistribution()..id = id,
          from: reservationByFloorDistributionProvider,
          name: r'reservationByFloorDistributionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ReservationByFloorDistributionHash,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is ReservationByFloorDistributionProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Reservation? runNotifierBuild(
    covariant _$ReservationByFloorDistribution notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}

typedef ReservationByFloorDistributionRef = NotifierProviderRef<Reservation?>;

/// See also [ReservationByFloorDistribution].
final reservationByFloorDistributionProvider =
    ReservationByFloorDistributionFamily();

class ReservationByFloorDistributionFamily extends Family<Reservation?> {
  ReservationByFloorDistributionFamily();

  ReservationByFloorDistributionProvider call(
    int id,
  ) {
    return ReservationByFloorDistributionProvider(
      id,
    );
  }

  @override
  NotifierProviderImpl<ReservationByFloorDistribution, Reservation?>
      getProviderOverride(
    covariant ReservationByFloorDistributionProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'reservationByFloorDistributionProvider';
}

abstract class _$ReservationByFloorDistribution
    extends BuildlessNotifier<Reservation?> {
  late final int id;

  Reservation? build(
    int id,
  );
}
