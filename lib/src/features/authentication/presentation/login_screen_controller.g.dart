// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_controller.dart';

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

String _$LoginScreenControllerHash() =>
    r'd8488ccae4b2f26be5a90f41df6035b023879df9';

/// See also [LoginScreenController].
final loginScreenControllerProvider =
    AutoDisposeAsyncNotifierProvider<LoginScreenController, bool>(
  LoginScreenController.new,
  name: r'loginScreenControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$LoginScreenControllerHash,
);
typedef LoginScreenControllerRef = AutoDisposeAsyncNotifierProviderRef<bool>;

abstract class _$LoginScreenController extends AutoDisposeAsyncNotifier<bool> {
  @override
  FutureOr<bool> build();
}
