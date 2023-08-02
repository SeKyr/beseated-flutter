import 'dart:async';

import 'package:beseated/src/features/floor_distribution/application/floor_distribution_service.dart';
import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/location/presentation/selected_location.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_by_floor_distibution.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_process_state.dart';
import 'package:beseated/src/features/reservation/presentation/selected_date.dart';
import 'package:beseated/src/features/reservation_request/application/reservation_request_service.dart';
import 'package:beseated/src/features/reservation_request/presentation/reservation_request_by_floor_distibution.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../../authentication/domain/user.dart';
import '../../authentication/presentation/logged_in_user.dart';
import '../../floor/presentation/selected_floor.dart';
import '../../reservation_request/domain/reservation_request.dart';
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

final lastTimeReloadedProvider = AutoDisposeStateProvider<AsyncValue<DateTime>>(
    (ref) => const AsyncLoading());

@riverpod
class ReservationScreenController extends _$ReservationScreenController {
  final Set<int> previouslyFilledReservationProviders = {};
  final Set<int> previouslyFilledReservationRequestProviders = {};

  bool floorDistsLoaded = false;
  bool reservationsAndRequestsLoaded = false;

  Timer? _timer;

  Location? location;

  @override
  FutureOr<bool> build() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initalizeListeners();
    });
    return false;
  }

  void _initalizeListeners() {
    _getReservationsAndRequestsOnDateChange();
    _getFloorDistributionsOnFloorChange();
    _updateLocationOnChange();
  }

  void _initalizeReloadTimer(DateTime date) {
    _timer?.cancel();
    // Set Timer to reload Data every Minute
    _timer = Timer.periodic(const Duration(seconds: 60), (timer) async {
      ref.read(lastTimeReloadedProvider.notifier).state = const AsyncLoading();
      await _getReservationsAndRequestsAndFillProvider(date);
      ref.read(lastTimeReloadedProvider.notifier).state =
          AsyncData(DateTime.now());
    });
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

  Future<void> _getReservationsAndRequestsOnDateChange() async {
    var selectedDate = ref.read(selectedDateProvider);
    await _getReservationsAndRequestsAndFillProviderAndInitalizeReloadInterval(
        selectedDate);
    ref.listen(selectedDateProvider, (previous, next) async {
      await _getReservationsAndRequestsAndFillProviderAndInitalizeReloadInterval(
          next);
    });
  }

  Future<void>
      _getReservationsAndRequestsAndFillProviderAndInitalizeReloadInterval(
          DateTime date) async {
    await _getReservationsAndRequestsAndFillProviderWithLoadingOverlay(date);
    _initalizeReloadTimer(date);
  }

  void _changeReservationsLoaded(bool value) {
    reservationsAndRequestsLoaded = value;
    ref.read(lastTimeReloadedProvider.notifier).state =
        value ? AsyncData(DateTime.now()) : const AsyncLoading();
    _updateState();
  }

  void _changeFloorDistsLoaded(bool value) {
    floorDistsLoaded = value;
    _updateState();
  }

  void _updateState() {
    if (reservationsAndRequestsLoaded && floorDistsLoaded) {
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

  Future _getReservationsAndRequestsAndFillProviderWithLoadingOverlay(
      DateTime date) async {
    _changeReservationsLoaded(false);
    await _getReservationsAndRequestsAndFillProvider(date);
    _changeReservationsLoaded(true);
  }

  Future<void> _getReservationsAndRequestsAndFillProvider(DateTime date) async {
    final reservations = await ref
        .read(reservationServiceProvider)
        .getReservationsByDate(date: date);
    final requests = await ref
        .read(reservationRequestServiceProvider)
        .getOwnReservationRequestsByDate(date: date);
    await _fillProviders(reservations, requests);
  }

  Future<void> _fillProviders(
      List<Reservation> reservations, List<ReservationRequest> requests) async {
    for (var reservation in reservations) {
      ref
          .read(reservationByFloorDistributionProvider(reservation.roomId)
              .notifier)
          .change(reservation);
    }

    _clearReservationProviders(reservations.map((r) => r.roomId).toSet());
    await _fillOwnReservations(reservations
        .where((reservation) =>
            reservation.email.toLowerCase() ==
            ref.read(loggedInUserProvider)!.email.toLowerCase())
        .toList());

    for (var request in requests) {
      ref
          .read(reservationRequestByFloorDistributionProvider(request.roomId)
              .notifier)
          .change(request);
    }
    _clearReservationRequestProviders(requests.map((r) => r.roomId).toSet());
  }

  Future<void>
      _clearReservationRequestProviderAfterReservationOfFloorDistribution(
          FloorDistribution reservedFloorDistribution) async {
    for (var requestedFloorDistirbutionId
        in previouslyFilledReservationRequestProviders) {
      var floorDistribution = await ref
          .read(floorDistributionServiceProvider)
          .getFloorDistributionById(id: requestedFloorDistirbutionId);
      if (reservedFloorDistribution.type == floorDistribution.type) {
        ref
            .read(reservationRequestByFloorDistributionProvider(
                    requestedFloorDistirbutionId)
                .notifier)
            .change(null);
      }
    }
  }

  Future<void> _fillOwnReservations(List<Reservation> ownReservations) async {
    List<ReservationAndFloorDistribution> list = List.empty(growable: true);
    for (var reservation in ownReservations) {
      var floorDistribution = await ref
          .read(floorDistributionServiceProvider)
          .getFloorDistributionById(id: reservation.roomId);
      list.add(ReservationAndFloorDistribution(
          reservation: reservation, floorDistribution: floorDistribution));
    }
    ref
        .read(loggedInUserProvider.notifier)
        .changeOwnReservationAndFloorDistributions(list);
  }

  void _clearReservationRequestProviders(
      Set<int> requestedFloorDistributionIds) {
    previouslyFilledReservationRequestProviders
        .difference(requestedFloorDistributionIds)
        .forEach((id) {
      ref
          .read(reservationRequestByFloorDistributionProvider(id).notifier)
          .change(null);
    });
    previouslyFilledReservationRequestProviders.clear();
    previouslyFilledReservationRequestProviders
        .addAll(requestedFloorDistributionIds);
  }

  void _clearReservationProviders(Set<int> reservedFloorDistributionIds) {
    previouslyFilledReservationProviders
        .difference(reservedFloorDistributionIds)
        .forEach((id) {
      ref
          .read(reservationByFloorDistributionProvider(id).notifier)
          .change(null);
    });
    previouslyFilledReservationProviders.clear();
    previouslyFilledReservationProviders.addAll(reservedFloorDistributionIds);
  }

  Future<void> handleFloorDistributionDoubleTap(
      FloorDistribution floorDistribution) async {
    final reservation =
        ref.read(reservationByFloorDistributionProvider(floorDistribution.id));
    final reservationRequest = ref.read(
        reservationRequestByFloorDistributionProvider(floorDistribution.id));
    var user = ref.read(loggedInUserProvider);
    var reservationProcessState = ReservationProcessState.evaluateState(
        floorDistribution: floorDistribution,
        reservation: reservation,
        request: reservationRequest,
        user: user!);
    switch (reservationProcessState) {
      case ReservationProcessState.reservable:
        reserveFloorDistribution(floorDistribution: floorDistribution);
        break;
      case ReservationProcessState.requestable:
        var content = localTexts.confirmReservationRequestDescription(
            floorDistribution.type.getLocalizedName(localTexts));
        AppUtils.showConfirmDialog(
            content,
            () =>
                requestFloorDistribution(floorDistribution: floorDistribution));
        break;
      case ReservationProcessState.foreignReservation:
        break;
      case ReservationProcessState.ownReservation:
        deleteReservation(reservation!, floorDistribution);
        break;
      case ReservationProcessState.ownReservationRequest:
        cancelReservationRequest(reservationRequest!);
        break;
      case ReservationProcessState.reservableButOwnReservationOnAnother:
        updateReservationFloorDistribution(
            user.getReservationByFloorDistributionType(floorDistribution.type)!,
            floorDistribution);
        break;
      case ReservationProcessState.requestableButOwnReservationOnAnother:
        var content =
            localTexts.confirmReservationRequestDeletsOwnReservationDescription(
                floorDistribution.type.getLocalizedName(localTexts));
        AppUtils.showConfirmDialog(content,
            () => _deleteOwnReservationToRequestOther(user, floorDistribution));
        break;
    }
  }

  void _deleteOwnReservationToRequestOther(
      User user, FloorDistribution floorDistribution) {
    var ownReservationToDelete =
        user.getReservationByFloorDistributionType(floorDistribution.type)!;
    _deleteReservationWithCallbacks(ownReservationToDelete, floorDistribution,
        () => requestFloorDistribution(floorDistribution: floorDistribution),
        onError: (_) => AppUtils.showErrorToast());
  }

  void deleteReservation(
      Reservation reservation, FloorDistribution floorDistribution) {
    _deleteReservationWithCallbacks(
        reservation,
        floorDistribution,
        () => AppUtils.showSuccessToast(
            AppLocalizations.of(navigatorKey.currentContext!)!
                .reservationDeletionSuccessToast),
        onError: (_) => AppUtils.showErrorToast());
  }

  void _deleteReservationWithCallbacks(Reservation reservation,
      FloorDistribution floorDistribution, Function onValue,
      {Function? onError}) {
    ref
        .read(reservationServiceProvider)
        .deleteReservation(id: reservation.id!)
        .then((_) {
      ref
          .read(reservationByFloorDistributionProvider(reservation.roomId)
              .notifier)
          .change(null);
      ref
          .read(loggedInUserProvider.notifier)
          .deleteReservationAndFloorDistributionByType(floorDistribution.type);
      onValue.call();
    }, onError: (_) => onError?.call());
  }

  void updateReservationFloorDistribution(
      Reservation reservation, FloorDistribution floorDistribution) {
    var newReservation = reservation.copyWith(roomId: floorDistribution.id);
    ref
        .read(reservationServiceProvider)
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
              ReservationAndFloorDistribution(
                  reservation: newReservation,
                  floorDistribution: floorDistribution),
              floorDistribution.type);
      AppUtils.showSuccessToast(
          AppLocalizations.of(navigatorKey.currentContext!)!
              .reservationChangeSuccessToast);
      previouslyFilledReservationProviders.add(floorDistribution.id);
    }, onError: (_) => AppUtils.showErrorToast());
  }

  void reserveFloorDistribution(
      {required FloorDistribution floorDistribution,
      Reservation? reservation}) {
    reservation ??= _getDefaultReservation(floorDistribution.id);
    ref
        .read(reservationServiceProvider)
        .postReservation(reservation: reservation)
        .then((newReservation) {
      ref
          .read(reservationByFloorDistributionProvider(floorDistribution.id)
              .notifier)
          .change(newReservation);
      ref
          .read(loggedInUserProvider.notifier)
          .changeReservationAndFloorDistributionByType(
              ReservationAndFloorDistribution(
                  reservation: newReservation,
                  floorDistribution: floorDistribution),
              floorDistribution.type);
      _clearReservationRequestProviderAfterReservationOfFloorDistribution(
              floorDistribution)
          .then((value) => AppUtils.showSuccessToast(
              AppLocalizations.of(navigatorKey.currentContext!)!
                  .reservationSuccessToast));
      previouslyFilledReservationProviders.add(floorDistribution.id);
    }, onError: (_) => AppUtils.showErrorToast());
  }

  void cancelReservationRequest(ReservationRequest reservationRequest) {
    ref
        .read(reservationRequestServiceProvider)
        .cancelReservationRequest(
            floorDistributionId: reservationRequest.roomId,
            date: reservationRequest.startdate)
        .then((_) {
      ref
          .read(reservationRequestByFloorDistributionProvider(
                  reservationRequest.roomId)
              .notifier)
          .change(null);
      AppUtils.showSuccessToast(
          AppLocalizations.of(navigatorKey.currentContext!)!
              .reservationRequestCancelationSuccessToast);
    }, onError: (_) => AppUtils.showErrorToast());
  }

  void requestFloorDistribution(
      {required FloorDistribution floorDistribution,
      ReservationRequest? reservationRequest}) {
    reservationRequest ??= _getDefaultReservationRequest(floorDistribution.id);
    ref
        .read(reservationRequestServiceProvider)
        .postReservationRequest(reservationRequest: reservationRequest)
        .then((newReservationRequest) {
      ref
          .read(reservationRequestByFloorDistributionProvider(
                  floorDistribution.id)
              .notifier)
          .change(newReservationRequest);
      previouslyFilledReservationRequestProviders.add(floorDistribution.id);
      AppUtils.showSuccessToast(
          AppLocalizations.of(navigatorKey.currentContext!)!
              .reservationRequestSuccessToast);
      previouslyFilledReservationRequestProviders.add(floorDistribution.id);
    }, onError: (_) => AppUtils.showErrorToast());
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

  ReservationRequest _getDefaultReservationRequest(int roomId) {
    final startdate =
        ref.read(selectedDateProvider).add(const Duration(hours: 7));
    final enddate =
        ref.read(selectedDateProvider).add(const Duration(hours: 20));
    return ReservationRequest(
        email: ref.read(loggedInUserProvider)!.email,
        roomId: roomId,
        startdate: startdate,
        enddate: enddate);
  }
}
