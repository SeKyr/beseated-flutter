// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_service.dart';

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

String _$reservationServiceHash() =>
    r'785e835a9611d496fe85be9b7ebdf79e56c26fa5';

/// See also [reservationService].
final reservationServiceProvider = AutoDisposeProvider<ReservationService>(
  reservationService,
  name: r'reservationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reservationServiceHash,
);
typedef ReservationServiceRef = AutoDisposeProviderRef<ReservationService>;
String _$reservationsByDateHash() =>
    r'85c124b6bd588b2713e5dc7ca18c32aae2b84f3b';

/// See also [reservationsByDate].
class ReservationsByDateProvider
    extends AutoDisposeFutureProvider<List<Reservation>> {
  ReservationsByDateProvider({
    required this.date,
  }) : super(
          (ref) => reservationsByDate(
            ref,
            date: date,
          ),
          from: reservationsByDateProvider,
          name: r'reservationsByDateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$reservationsByDateHash,
        );

  final DateTime date;

  @override
  bool operator ==(Object other) {
    return other is ReservationsByDateProvider && other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef ReservationsByDateRef = AutoDisposeFutureProviderRef<List<Reservation>>;

/// See also [reservationsByDate].
final reservationsByDateProvider = ReservationsByDateFamily();

class ReservationsByDateFamily extends Family<AsyncValue<List<Reservation>>> {
  ReservationsByDateFamily();

  ReservationsByDateProvider call({
    required DateTime date,
  }) {
    return ReservationsByDateProvider(
      date: date,
    );
  }

  @override
  AutoDisposeFutureProvider<List<Reservation>> getProviderOverride(
    covariant ReservationsByDateProvider provider,
  ) {
    return call(
      date: provider.date,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'reservationsByDateProvider';
}

String _$postReservationHash() => r'ef1da7b3863be4e768274ba4d5191e1c0a697699';

/// See also [postReservation].
class PostReservationProvider extends AutoDisposeFutureProvider<dynamic> {
  PostReservationProvider({
    required this.reservation,
  }) : super(
          (ref) => postReservation(
            ref,
            reservation: reservation,
          ),
          from: postReservationProvider,
          name: r'postReservationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postReservationHash,
        );

  final Reservation reservation;

  @override
  bool operator ==(Object other) {
    return other is PostReservationProvider && other.reservation == reservation;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, reservation.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef PostReservationRef = AutoDisposeFutureProviderRef<dynamic>;

/// See also [postReservation].
final postReservationProvider = PostReservationFamily();

class PostReservationFamily extends Family<AsyncValue<dynamic>> {
  PostReservationFamily();

  PostReservationProvider call({
    required Reservation reservation,
  }) {
    return PostReservationProvider(
      reservation: reservation,
    );
  }

  @override
  AutoDisposeFutureProvider<dynamic> getProviderOverride(
    covariant PostReservationProvider provider,
  ) {
    return call(
      reservation: provider.reservation,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'postReservationProvider';
}

String _$deleteReservationHash() => r'4fa508631ec7741b0c531ae6bd7030502fcbeb36';

/// See also [deleteReservation].
class DeleteReservationProvider extends AutoDisposeFutureProvider<dynamic> {
  DeleteReservationProvider({
    required this.id,
  }) : super(
          (ref) => deleteReservation(
            ref,
            id: id,
          ),
          from: deleteReservationProvider,
          name: r'deleteReservationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deleteReservationHash,
        );

  final int id;

  @override
  bool operator ==(Object other) {
    return other is DeleteReservationProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef DeleteReservationRef = AutoDisposeFutureProviderRef<dynamic>;

/// See also [deleteReservation].
final deleteReservationProvider = DeleteReservationFamily();

class DeleteReservationFamily extends Family<AsyncValue<dynamic>> {
  DeleteReservationFamily();

  DeleteReservationProvider call({
    required int id,
  }) {
    return DeleteReservationProvider(
      id: id,
    );
  }

  @override
  AutoDisposeFutureProvider<dynamic> getProviderOverride(
    covariant DeleteReservationProvider provider,
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
  String? get name => r'deleteReservationProvider';
}
