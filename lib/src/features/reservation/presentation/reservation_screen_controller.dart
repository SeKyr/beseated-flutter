import 'package:beseated/src/features/floor_distribution/application/floor_distribution_service.dart';
import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/location/presentation/selected_location.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_by_floor_distibution.dart';
import 'package:beseated/src/features/reservation/presentation/selected_date.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../../authentication/presentation/logged_in_user.dart';
import '../../floor/presentation/selected_floor.dart';
import '../application/reservation_service.dart';
import '../domain/reservation.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../location/domain/location.dart';

part 'reservation_screen_controller.g.dart';

final reservationScreenFloorDistributionsProvider =
    AutoDisposeStateProvider<List<FloorDistribution>>((ref) {
  return List.empty();
});

final reservationScreenTitleProvider = AutoDisposeStateProvider<String>((ref) {
  return 'BeSeated';
});

@riverpod
class ReservationScreenController extends _$ReservationScreenController {
  final Set<int> previouslyFilledProviders = {};

  bool floorDistsLoaded = false;
  bool reservationsLoaded = false;

  Location? location;

  @override
  FutureOr<bool> build() {
    _initalizeListeners();
    return false;
  }

  void _initalizeListeners() {
    _getReservationsOnDateChange();
    _getFloorDistributionsOnFloorChange();
    _updateLocationOnChange();
  }

  void _updateLocationOnChange() {
    ref.listen(selectedLocationProvider, (previous, next) {
      location = next.value;
      _updateState();
    });
  }

  void _getFloorDistributionsOnFloorChange() {
    ref.listen(selectedFloorProvider, (_, next) async {
      _changeFloorDistsLoaded(false);
      if (next != null) {
        var floorDistributions = await ref
            .watch(floorDistributionServiceProvider)
            .getFloorDistributionsByFloorId(id: next.id);
        ref.read(reservationScreenFloorDistributionsProvider.notifier).state =
            floorDistributions;
        _changeFloorDistsLoaded(true);
      }
    });
  }

  void _getReservationsOnDateChange() {
    _getReservationsAndFillProvider(ref.read(selectedDateProvider));
    ref.listen(selectedDateProvider, (previous, next) async {
      await _getReservationsAndFillProvider(next);
    });
  }

  void _changeReservationsLoaded(bool value) {
    reservationsLoaded = value;
    _updateState();
  }

  void _changeFloorDistsLoaded(bool value) {
    floorDistsLoaded = value;
    _updateState();
  }

  void _updateState() {
    if (reservationsLoaded && floorDistsLoaded) {
      state = const AsyncData(true);
    } else {
      state = const AsyncLoading();
    }
    _updateTitle();
  }

  void _updateTitle() {
    Future.delayed(const Duration(seconds: 2), () {
      if (state.value == true && location != null) {
        ref.read(reservationScreenTitleProvider.notifier).state =
            location!.name;
      }
    });
  }

  Future _getReservationsAndFillProvider(DateTime date) async {
    _changeReservationsLoaded(false);
    final data = await ref
        .read(reservationServiceProvider)
        .getReservationsByDate(date: date);
    await _fillProviders(data);
    _changeReservationsLoaded(true);
  }

  Future<void> _fillProviders(List<Reservation> reservations) async {
    for (var reservation in reservations) {
      ref
          .read(reservationByFloorDistributionProvider(reservation.roomId)
              .notifier)
          .change(reservation);
    }
    _clearProviders(reservations.map((r) => r.roomId).toSet());
    await _fillOwnReservations(reservations
        .where((reservation) =>
            reservation.email.toLowerCase() ==
            ref.read(loggedInUserProvider)!.email.toLowerCase())
        .toList());
  }

  Future<void> _fillOwnReservations(List<Reservation> ownReservations) async {
    for (var reservation in ownReservations) {
      var floorDistribution = await ref
          .read(floorDistributionServiceProvider)
          .getFloorDistributionById(id: reservation.roomId);
      ref
          .read(loggedInUserProvider.notifier)
          .changeReservationAndFloorDistributionByType(
              type: floorDistribution.type,
              reservation: reservation,
              floorDistribution: floorDistribution);
    }
  }

  void _clearProviders(Set<int> reservationRoomIds) {
    previouslyFilledProviders.difference(reservationRoomIds).forEach((id) {
      ref
          .read(reservationByFloorDistributionProvider(id).notifier)
          .change(null);
    });
    previouslyFilledProviders.clear();
    previouslyFilledProviders.addAll(reservationRoomIds);
    ref
        .read(loggedInUserProvider.notifier)
        .changeReservationAndFloorDistributionByType(
            type: FloorDistributionType.table);
    ref
        .read(loggedInUserProvider.notifier)
        .changeReservationAndFloorDistributionByType(
            type: FloorDistributionType.parkingLot);
  }

  Future<void> handleFloorDistributionDoubleTap(
      FloorDistribution floorDistribution) async {
    final reservation =
        ref.read(reservationByFloorDistributionProvider(floorDistribution.id));
    if (reservation == null) {
      var userReservationByFloorDistributionType =
          getUserReservationByFloorDistributionType(floorDistribution.type);
      if (userReservationByFloorDistributionType == null) {
        reserveFloorDistribution(floorDistribution);
      } else {
        updateReservationFloorDistribution(
            userReservationByFloorDistributionType, floorDistribution);
      }
    } else {
      if (reservation.email == ref.read(loggedInUserProvider)!.email) {
        deleteReservation(reservation, floorDistribution);
      }
    }
  }

  Reservation? getUserReservationByFloorDistributionType(
      FloorDistributionType type) {
    var user = ref.read(loggedInUserProvider);
    if (type == FloorDistributionType.table) {
      return user?.workingPlaceReservation;
    } else if (type == FloorDistributionType.parkingLot) {
      return user?.parkingLotReservation;
    }
  }

  void deleteReservation(
      Reservation reservation, FloorDistribution floorDistribution) {
    ref
        .watch(reservationServiceProvider)
        .deleteReservation(id: reservation.id!)
        .then((_) {
      ref
          .read(reservationByFloorDistributionProvider(reservation.roomId)
              .notifier)
          .change(null);
      ref
          .read(loggedInUserProvider.notifier)
          .changeReservationAndFloorDistributionByType(
              type: floorDistribution.type);
      _showSuccessToast(AppLocalizations.of(navigatorKey.currentContext!)!
          .reservationDeletionSuccessToast);
    }, onError: (_) => _showErrorToast());
  }

  void updateReservationFloorDistribution(
      Reservation reservation, FloorDistribution floorDistribution) {
    var newReservation = reservation.copyWith(roomId: floorDistribution.id);
    ref
        .watch(reservationServiceProvider)
        .putReservation(reservation: newReservation)
        .then((_) {
      ref
          .read(reservationByFloorDistributionProvider(reservation.roomId)
              .notifier)
          .change(null);
      ref
          .read(reservationByFloorDistributionProvider(newReservation.roomId)
              .notifier)
          .change(newReservation);
      ref
          .read(loggedInUserProvider.notifier)
          .changeReservationAndFloorDistributionByType(
              type: floorDistribution.type,
              reservation: newReservation,
              floorDistribution: floorDistribution);
      _showSuccessToast(AppLocalizations.of(navigatorKey.currentContext!)!
          .reservationChangeSuccessToast);
    }, onError: (_) => _showErrorToast());
  }

  Future<void> reserveFloorDistribution(
      FloorDistribution floorDistribution) async {
    final reservation = _getDefaultReservation(floorDistribution.id);
    ref
        .watch(reservationServiceProvider)
        .postReservation(reservation: reservation)
        .then((newReservation) {
      ref
          .read(reservationByFloorDistributionProvider(floorDistribution.id)
              .notifier)
          .change(newReservation);
      ref
          .read(loggedInUserProvider.notifier)
          .changeReservationAndFloorDistributionByType(
              type: floorDistribution.type,
              reservation: newReservation,
              floorDistribution: floorDistribution);
      _showSuccessToast(AppLocalizations.of(navigatorKey.currentContext!)!
          .reservationSuccessToast);
    }, onError: (_) => _showErrorToast());
  }

  void _showErrorToast() {
    CherryToast.error(
      title:
          Text(AppLocalizations.of(navigatorKey.currentContext!)!.errorToast),
      toastPosition: Position.bottom,
      animationType: AnimationType.fromBottom,
      animationDuration: const Duration(milliseconds: 200),
      toastDuration: const Duration(seconds: 1, milliseconds: 500),
    ).show(navigatorKey.currentContext!);
  }

  void _showSuccessToast(String text) {
    CherryToast.success(
      title: Text(text),
      toastPosition: Position.bottom,
      animationType: AnimationType.fromBottom,
      animationDuration: const Duration(milliseconds: 200),
      toastDuration: const Duration(seconds: 1, milliseconds: 500),
    ).show(navigatorKey.currentContext!);
  }

  Reservation _getDefaultReservation(int roomId) {
    final startdate =
        ref.read(selectedDateProvider).add(const Duration(hours: 7));
    final enddate =
        ref.read(selectedDateProvider).add(const Duration(hours: 20));
    return Reservation(
        email: ref.read(loggedInUserProvider)!.email,
        roomId: roomId,
        startdate: startdate,
        enddate: enddate);
  }
}
