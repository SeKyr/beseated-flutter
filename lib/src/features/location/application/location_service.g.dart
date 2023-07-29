// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_service.dart';

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

String _$locationServiceHash() => r'dd0a7633f4bfd8801f93ed51d7ffe33ad8271c5e';

/// See also [locationService].
final locationServiceProvider = AutoDisposeProvider<LocationService>(
  locationService,
  name: r'locationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationServiceHash,
);
typedef LocationServiceRef = AutoDisposeProviderRef<LocationService>;
String _$allLocationsHash() => r'83a7bcc30942d7f11e071da304a24af8029721ce';

/// See also [allLocations].
final allLocationsProvider = AutoDisposeFutureProvider<List<Location>>(
  allLocations,
  name: r'allLocationsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allLocationsHash,
);
typedef AllLocationsRef = AutoDisposeFutureProviderRef<List<Location>>;
