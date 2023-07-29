// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_service.dart';

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

String _$floorServiceHash() => r'4eb36e2575d7145b4302c9408ff6c95d40668e36';

/// See also [floorService].
final floorServiceProvider = AutoDisposeProvider<FloorService>(
  floorService,
  name: r'floorServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$floorServiceHash,
);
typedef FloorServiceRef = AutoDisposeProviderRef<FloorService>;
String _$floorsByLocationIdHash() =>
    r'8877df84bc039da2418421e52b84494583571747';

/// See also [floorsByLocationId].
class FloorsByLocationIdProvider
    extends AutoDisposeFutureProvider<List<Floor>> {
  FloorsByLocationIdProvider({
    required this.id,
  }) : super(
          (ref) => floorsByLocationId(
            ref,
            id: id,
          ),
          from: floorsByLocationIdProvider,
          name: r'floorsByLocationIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$floorsByLocationIdHash,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is FloorsByLocationIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FloorsByLocationIdRef = AutoDisposeFutureProviderRef<List<Floor>>;

/// See also [floorsByLocationId].
final floorsByLocationIdProvider = FloorsByLocationIdFamily();

class FloorsByLocationIdFamily extends Family<AsyncValue<List<Floor>>> {
  FloorsByLocationIdFamily();

  FloorsByLocationIdProvider call({
    required int id,
  }) {
    return FloorsByLocationIdProvider(
      id: id,
    );
  }

  @override
  AutoDisposeFutureProvider<List<Floor>> getProviderOverride(
    covariant FloorsByLocationIdProvider provider,
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
  String? get name => r'floorsByLocationIdProvider';
}
