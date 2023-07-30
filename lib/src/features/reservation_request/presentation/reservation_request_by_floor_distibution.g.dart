// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_request_by_floor_distibution.dart';

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

String _$ReservationRequestByFloorDistributionHash() =>
    r'4ac8b324cef02dcb6a29eec589c42d42e9de298f';

/// See also [ReservationRequestByFloorDistribution].
class ReservationRequestByFloorDistributionProvider
    extends NotifierProviderImpl<ReservationRequestByFloorDistribution,
        ReservationRequest?> {
  ReservationRequestByFloorDistributionProvider(
    this.id,
  ) : super(
          () => ReservationRequestByFloorDistribution()..id = id,
          from: reservationRequestByFloorDistributionProvider,
          name: r'reservationRequestByFloorDistributionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$ReservationRequestByFloorDistributionHash,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is ReservationRequestByFloorDistributionProvider &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  ReservationRequest? runNotifierBuild(
    covariant _$ReservationRequestByFloorDistribution notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}

typedef ReservationRequestByFloorDistributionRef
    = NotifierProviderRef<ReservationRequest?>;

/// See also [ReservationRequestByFloorDistribution].
final reservationRequestByFloorDistributionProvider =
    ReservationRequestByFloorDistributionFamily();

class ReservationRequestByFloorDistributionFamily
    extends Family<ReservationRequest?> {
  ReservationRequestByFloorDistributionFamily();

  ReservationRequestByFloorDistributionProvider call(
    int id,
  ) {
    return ReservationRequestByFloorDistributionProvider(
      id,
    );
  }

  @override
  NotifierProviderImpl<ReservationRequestByFloorDistribution,
      ReservationRequest?> getProviderOverride(
    covariant ReservationRequestByFloorDistributionProvider provider,
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
  String? get name => r'reservationRequestByFloorDistributionProvider';
}

abstract class _$ReservationRequestByFloorDistribution
    extends BuildlessNotifier<ReservationRequest?> {
  late final int id;

  ReservationRequest? build(
    int id,
  );
}
