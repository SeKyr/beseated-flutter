// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'microsoft_graph_service.dart';

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

String _$microsoftGraphServiceHash() =>
    r'fd1254f83768bcd1dde44b1118e745a46b57f5d4';

/// See also [microsoftGraphService].
final microsoftGraphServiceProvider =
    AutoDisposeProvider<MicrosoftGraphService>(
  microsoftGraphService,
  name: r'microsoftGraphServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$microsoftGraphServiceHash,
);
typedef MicrosoftGraphServiceRef
    = AutoDisposeProviderRef<MicrosoftGraphService>;
String _$loadUserDetailsHash() => r'e6ebcd36da7d1c8f05fd89b485122e62bfb6bd5e';

/// See also [loadUserDetails].
final loadUserDetailsProvider = AutoDisposeFutureProvider<void>(
  loadUserDetails,
  name: r'loadUserDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadUserDetailsHash,
);
typedef LoadUserDetailsRef = AutoDisposeFutureProviderRef<void>;
