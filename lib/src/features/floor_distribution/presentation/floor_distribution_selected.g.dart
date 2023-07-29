// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_distribution_selected.dart';

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

String _$FloorDistributionSelectedHash() =>
    r'70b6fcdc25973b64c7664f388e72eaa2fcc570bf';

/// See also [FloorDistributionSelected].
class FloorDistributionSelectedProvider
    extends AutoDisposeNotifierProviderImpl<FloorDistributionSelected, bool> {
  FloorDistributionSelectedProvider(
    this.id,
  ) : super(
          () => FloorDistributionSelected()..id = id,
          from: floorDistributionSelectedProvider,
          name: r'floorDistributionSelectedProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$FloorDistributionSelectedHash,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is FloorDistributionSelectedProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  bool runNotifierBuild(
    covariant _$FloorDistributionSelected notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}

typedef FloorDistributionSelectedRef = AutoDisposeNotifierProviderRef<bool>;

/// See also [FloorDistributionSelected].
final floorDistributionSelectedProvider = FloorDistributionSelectedFamily();

class FloorDistributionSelectedFamily extends Family<bool> {
  FloorDistributionSelectedFamily();

  FloorDistributionSelectedProvider call(
    int id,
  ) {
    return FloorDistributionSelectedProvider(
      id,
    );
  }

  @override
  AutoDisposeNotifierProviderImpl<FloorDistributionSelected, bool>
      getProviderOverride(
    covariant FloorDistributionSelectedProvider provider,
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
  String? get name => r'floorDistributionSelectedProvider';
}

abstract class _$FloorDistributionSelected
    extends BuildlessAutoDisposeNotifier<bool> {
  late final int id;

  bool build(
    int id,
  );
}
