// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_distribution_service.dart';

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

String _$floorDistributionServiceHash() =>
    r'460c094e1bcf91b6f27815711cb7c341ae6858a6';

/// See also [floorDistributionService].
final floorDistributionServiceProvider =
    AutoDisposeProvider<FloorDistributionService>(
  floorDistributionService,
  name: r'floorDistributionServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$floorDistributionServiceHash,
);
typedef FloorDistributionServiceRef
    = AutoDisposeProviderRef<FloorDistributionService>;
String _$floorDistributionsByFloorIdHash() =>
    r'bbb812b454a4faabb3139bd2c10cfa22326b207e';

/// See also [floorDistributionsByFloorId].
class FloorDistributionsByFloorIdProvider
    extends AutoDisposeFutureProvider<List<FloorDistribution>> {
  FloorDistributionsByFloorIdProvider({
    required this.id,
  }) : super(
          (ref) => floorDistributionsByFloorId(
            ref,
            id: id,
          ),
          from: floorDistributionsByFloorIdProvider,
          name: r'floorDistributionsByFloorIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$floorDistributionsByFloorIdHash,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is FloorDistributionsByFloorIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FloorDistributionsByFloorIdRef
    = AutoDisposeFutureProviderRef<List<FloorDistribution>>;

/// See also [floorDistributionsByFloorId].
final floorDistributionsByFloorIdProvider = FloorDistributionsByFloorIdFamily();

class FloorDistributionsByFloorIdFamily
    extends Family<AsyncValue<List<FloorDistribution>>> {
  FloorDistributionsByFloorIdFamily();

  FloorDistributionsByFloorIdProvider call({
    required int id,
  }) {
    return FloorDistributionsByFloorIdProvider(
      id: id,
    );
  }

  @override
  AutoDisposeFutureProvider<List<FloorDistribution>> getProviderOverride(
    covariant FloorDistributionsByFloorIdProvider provider,
  ) {
    return call(
      id: provider.id,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'floorDistributionsByFloorIdProvider';
}
