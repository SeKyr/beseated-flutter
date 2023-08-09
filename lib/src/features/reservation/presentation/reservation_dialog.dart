import 'package:beseated/src/features/authentication/presentation/logged_in_user.dart';
import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_process_state.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_screen_controller.dart';
import 'package:beseated/src/features/reservation/presentation/selected_date.dart';
import 'package:beseated/src/features/reservation_request/domain/reservation_request.dart';
import 'package:beseated/src/features/series/domain/series_description.dart';
import 'package:beseated/src/features/series/presentation/series_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../shared/app_utils.dart';
import '../../authentication/domain/user.dart';
import '../domain/reservation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReservationDialog extends ConsumerWidget {
  const ReservationDialog(
      {super.key,
      required this.floorDistribution,
      required this.user,
      this.reservation,
      this.reservationRequest});

  final FloorDistribution floorDistribution;
  final User user;
  final Reservation? reservation;
  final ReservationRequest? reservationRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appLocalizations = AppLocalizations.of(context)!;
    var details = ReservationDialogDetails
        .fromFloorDistributionAndReservationAndReservationRequestAndUser(
            floorDistribution: floorDistribution,
            reservation: reservation,
            reservationRequest: reservationRequest,
            user: user,
            appLocalizations: appLocalizations,
            ref: ref);
    var date = ref.read(selectedDateProvider);
    _setReadOnlyOnDateBeforeToday(details, date);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: const SizedBox.shrink(),
        title: Text(details.title),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close))
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          var width = constraints.maxWidth;
          return SingleChildScrollView(
              child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations
                            .reservationDialogFloorDistributionDetails,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      _getIconWithText(
                          text: floorDistribution.name,
                          description: floorDistribution.type
                              .getLocalizedName(AppLocalizations.of(context)!),
                          iconData: floorDistribution.type.getIconData(),
                          width: width),
                      _getIconWithText(
                          iconData: Icons.person,
                          text: floorDistribution.ownerFullName,
                          description: appLocalizations
                              .reservationDialogFloorDistributionOwnerDescription,
                          width: width),
                      _getIconWithText(
                          iconData: Icons.info_outline,
                          text: floorDistribution.notification ?? '-',
                          description: appLocalizations
                              .reservationDialogFloorDistributionInfoDescription,
                          width: width)
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appLocalizations.reservationDialogReservationDetails,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      _getIconWithText(
                          text: details.userFullName,
                          description: appLocalizations
                              .reservationDialogReservationUserDescription,
                          iconData: Icons.person,
                          width: width),
                      _getIconWithText(
                          text: date.toLocalDateString(context),
                          description: appLocalizations.date,
                          iconData: Icons.calendar_today_rounded,
                          width: width),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(flex: 1, child: Consumer(
                            builder: (context, ref, child) {
                              var starttime =
                              ref.watch(details.starttimeProvider);
                              var onTap = details.readonly ? null : () => _selectTime(context, details.starttimeProvider, ref);
                              return _getIconWithText(
                                  iconData: Icons.watch_later,
                                  text: starttime.toLocalTimeString(context),
                                  description: appLocalizations.begin,
                                onTap: onTap,
                              );
                            },
                          ),),
                          Flexible(flex: 1,child: Consumer(
                            builder: (context, ref, child) {
                              var endtime = ref.watch(details.endtimeProvider);
                              var onTap = details.readonly ? null : () => _selectTime(context, details.endtimeProvider, ref);
                              return _getIconWithText(
                                  iconData: Icons.watch_later,
                                  text: endtime.toLocalTimeString(context),
                                  description: appLocalizations.end,
                                  onTap: onTap
                              );
                            },
                          ),),
                        ],
                      ),
                      details.seriesProvider != null
                          ? Consumer(
                              builder: (context, ref, child) {
                                var seriesDescription =
                                    ref.watch(details.seriesProvider!);
                                var onTap = details.readonly ? null : () => showDialog(
                                  context: context,
                                  builder: (context) => SeriesSelection(seriesDescriptionProvider: details.seriesProvider!));
                                return _getIconWithText(
                                    iconData: Icons.repeat,
                                    text: seriesDescription.type
                                        .getLocalizedName(appLocalizations),
                                    description: appLocalizations
                                        .reservationDialogReservationRepititionDescription,
                                    width: width, onTap: onTap,
                            );})
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
              ],
            ),
          ));
        },
      ),
      persistentFooterButtons: details.readonly ? null : details.actions,
    );
  }

  void _setReadOnlyOnDateBeforeToday(ReservationDialogDetails details, DateTime selectedDate) {
    var today = DateTime.now().copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    selectedDate = selectedDate.copyWith(hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    if(selectedDate.isBefore(today)) {
      details.readonly = true;
    }
  }

  Future<void> _selectTime(BuildContext context, AutoDisposeStateProvider<DateTime> timeProvider, WidgetRef ref) async {
    var previousTime = TimeOfDay.fromDateTime(ref.read(timeProvider));
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: previousTime);

    if (pickedTime != null && pickedTime != previousTime) {
      ref.read(timeProvider.notifier).state = ref.read(selectedDateProvider).copyWith(hour: pickedTime.hour, minute: pickedTime.minute);
    }
  }

  Widget _getIconWithText(
      {required IconData iconData,
      required String text,
      required String description,
        void Function()? onTap,
      double? width}) {
    var colorScheme = Theme.of(navigatorKey.currentContext!).colorScheme;
    var iconColor = onTap != null ? colorScheme.primary : colorScheme.onBackground;
    var iconToShow = Icon(
      iconData,
      color: iconColor,
    );
    return SizedBox(
      width: width,
      child: TextField(
        onTap: onTap,
        readOnly: true,
        decoration: InputDecoration(labelText: description, icon: iconToShow),
        controller: TextEditingController(text: text),
        style: TextStyle(
            fontSize: 13,
            color: Theme.of(navigatorKey.currentContext!)
                .colorScheme
                .onBackground),
      ),
    );
  }
}

class ReservationDialogDetails {
  ReservationDialogDetails(
      {this.actions,
      this.seriesProvider,
      required this.title,
      this.readonly = true,
      required this.user,
      required this.endtimeProvider,
      required this.starttimeProvider});

  List<Widget>? actions;
  String title;
  bool readonly;
  String user;
  AutoDisposeStateProvider<DateTime> starttimeProvider;
  AutoDisposeStateProvider<DateTime> endtimeProvider;
  AutoDisposeStateProvider<SeriesDescription>? seriesProvider;

  String get userFullName {
    var splittedByDot = user.split('.');
    var prename = splittedByDot[0];
    var splittedByDotSplittedByAt = splittedByDot[1].split('@');
    var surname = splittedByDotSplittedByAt[0];
    prename = prename.capitalize();
    surname = surname.capitalize();
    return "$prename $surname";
  }

  static ReservationDialogDetails
      fromFloorDistributionAndReservationAndReservationRequestAndUser({
    required FloorDistribution floorDistribution,
    required Reservation? reservation,
    required ReservationRequest? reservationRequest,
    required User user,
    required AppLocalizations appLocalizations,
    required WidgetRef ref,
  }) {
    var floorDistributionReservationState =
        FloorDistributionReservationState.evaluateState(
            floorDistribution: floorDistribution,
            reservation: reservation,
            request: reservationRequest,
            user: user);
    ReservationDialogDetails details;
    switch (floorDistributionReservationState) {
      case FloorDistributionReservationState.foreignReservation:
        details = ReservationDialogDetails(
            title: appLocalizations.reservationDialogForeignReservation,
            user: reservation!.email,
            starttimeProvider: _getDateTimeProvider(reservation.startdate),
            endtimeProvider: _getDateTimeProvider(reservation.enddate));
        break;
      case FloorDistributionReservationState.ownReservation:
        details = ReservationDialogDetails(
            title: appLocalizations.reservationDialogOwnReservation,
            user: reservation!.email,
            readonly: false,
            starttimeProvider: _getDateTimeProvider(reservation.startdate),
            endtimeProvider: _getDateTimeProvider(reservation.enddate));
        break;
      case FloorDistributionReservationState.ownReservationRequest:
        details = ReservationDialogDetails(
            title: appLocalizations.reservationDialogOwnReservationRequest,
            user: reservation!.email,
            starttimeProvider: _getDateTimeProvider(reservation.startdate),
            endtimeProvider: _getDateTimeProvider(reservation.enddate));
        break;
      case FloorDistributionReservationState.requestable:
        details = ReservationDialogDetails(
            title: appLocalizations.reservationDialogRequestable,
            user: user.email,
            readonly: false,
            starttimeProvider: _getDateTimeProvider(_getDefaultStarttime()),
            endtimeProvider: _getDateTimeProvider(_getDefaultEndtime()));
        break;
      case FloorDistributionReservationState
            .requestableButOwnReservationOnAnother:
        details = ReservationDialogDetails(
            title: appLocalizations
                .reservationDialogRequestableButOwnReservationOnAnother,
            user: user.email,
            readonly: false,
            starttimeProvider: _getDateTimeProvider(_getDefaultStarttime()),
            endtimeProvider: _getDateTimeProvider(_getDefaultEndtime()));
        break;
      case FloorDistributionReservationState.reservable:
        details = ReservationDialogDetails(
            title: appLocalizations.reservationDialogReservable,
            user: user.email,
            seriesProvider: _getDefaultSeriesDescriptionProvider(),
            readonly: false,
            starttimeProvider: _getDateTimeProvider(_getDefaultStarttime()),
            endtimeProvider: _getDateTimeProvider(_getDefaultEndtime()));
        break;
      case FloorDistributionReservationState
            .reservableButOwnReservationOnAnother:
        details = ReservationDialogDetails(
            title: appLocalizations
                .reservationDialogReservableButOwnReservationOnAnother,
            user: user.email,
            readonly: false,
            starttimeProvider: _getDateTimeProvider(_getDefaultStarttime()),
            endtimeProvider: _getDateTimeProvider(_getDefaultEndtime()));
        break;
    }
    _addActions(floorDistribution: floorDistribution, reservation: reservation, reservationRequest: reservationRequest, floorDistributionReservationState: floorDistributionReservationState, reservationDialogDetails: details, appLocalizations: appLocalizations, ref: ref);
    return details;
  }

  static void _addActions({
    required FloorDistribution floorDistribution,
    required Reservation? reservation,
    required ReservationRequest? reservationRequest,
    required FloorDistributionReservationState
        floorDistributionReservationState,
    required ReservationDialogDetails reservationDialogDetails,
    required AppLocalizations appLocalizations,
    required WidgetRef ref,
  }) {
    switch (floorDistributionReservationState) {
      case FloorDistributionReservationState.foreignReservation:
        break;
      case FloorDistributionReservationState.ownReservation:
        reservationDialogDetails.actions = List.empty(growable: true);
        if (reservation!.series != null) {
          reservationDialogDetails.actions!.add(_getSeriesOrReservationDeleteButton(() => ref
              .read(reservationScreenControllerProvider.notifier)
              .deleteReservation(reservation, floorDistribution), () => ref
              .read(reservationScreenControllerProvider.notifier)
              .deleteSeries(reservation.series!.id, floorDistribution), appLocalizations));
        } else {
          reservationDialogDetails.actions!.add(_getDeleteButton(() =>
              ref
                  .read(reservationScreenControllerProvider.notifier)
                  .deleteReservation(reservation, floorDistribution)
          , appLocalizations));
        }
        reservationDialogDetails.actions!.add(Consumer(
          builder: (context, ref, child) {
            var starttime =
                ref.watch(reservationDialogDetails.starttimeProvider);
            var endtime = ref.watch(reservationDialogDetails.endtimeProvider);
            var newStartDateTime = reservation.startdate
                .copyWith(hour: starttime.hour, minute: starttime.minute);
            var newEndDateTime = reservation.enddate
                .copyWith(hour: endtime.hour, minute: endtime.minute);
            bool timeHasChanged = reservation.startdate != newStartDateTime ||
                reservation.enddate != newEndDateTime;
            onSafe() {
              ref
                  .read(reservationScreenControllerProvider.notifier)
                  .updateReservation(
                      reservation,
                      reservation.copyWith(
                          startdate: newStartDateTime, enddate: newEndDateTime),
                      floorDistribution);
            }

            return _getSafeButton(
                timeHasChanged ? onSafe() : null, appLocalizations);
          },
        ));
        break;
      case FloorDistributionReservationState.ownReservationRequest:
        reservationDialogDetails.actions = List.empty(growable: true);
        reservationDialogDetails.actions!.add(_getDeleteButton(
            () => ref
                .read(reservationScreenControllerProvider.notifier)
                .cancelReservationRequest(reservationRequest!),
            appLocalizations));
        break;
      case FloorDistributionReservationState.requestable:
        reservationDialogDetails.actions = List.empty(growable: true);
        reservationDialogDetails.actions!.add(_getSafeButton(() {
          var starttime = ref.read(reservationDialogDetails.starttimeProvider);
          var endtime = ref.read(reservationDialogDetails.endtimeProvider);
          var date = ref.read(selectedDateProvider);
          var startDateTime =
              date.copyWith(hour: starttime.hour, minute: starttime.minute);
          var endDateTime =
              date.copyWith(hour: endtime.hour, minute: endtime.minute);
          ref
              .read(reservationScreenControllerProvider.notifier)
              .requestFloorDistribution(
                  floorDistribution: floorDistribution,
                  reservationRequest: ReservationRequest(
                      email: reservationDialogDetails.user,
                      floorDistributionId: floorDistribution.id,
                      startdate: startDateTime,
                      enddate: endDateTime));
        }, appLocalizations));
        break;
      case FloorDistributionReservationState
            .requestableButOwnReservationOnAnother:
        var user = ref.read(loggedInUserProvider)!;
        var starttime = ref.read(reservationDialogDetails.starttimeProvider);
        var endtime = ref.read(reservationDialogDetails.endtimeProvider);
        var date = ref.read(selectedDateProvider);
        var startDateTime =
            date.copyWith(hour: starttime.hour, minute: starttime.minute);
        var endDateTime =
            date.copyWith(hour: endtime.hour, minute: endtime.minute);
        ref
            .read(reservationScreenControllerProvider.notifier)
            .deleteOwnReservationToRequestOther(user, floorDistribution,
                reservationRequest: ReservationRequest(
                    email: reservationDialogDetails.user,
                    floorDistributionId: floorDistribution.id,
                    startdate: startDateTime,
                    enddate: endDateTime));
        break;
      case FloorDistributionReservationState.reservable:
        // TODO: Serie erstellen, falls ausgewählt
        reservationDialogDetails.actions = List.empty(growable: true);
        reservationDialogDetails.actions!.add(_getSafeButton(() {
          var starttime = ref.read(reservationDialogDetails.starttimeProvider);
          var endtime = ref.read(reservationDialogDetails.endtimeProvider);
          var date = ref.read(selectedDateProvider);
          var startDateTime =
          date.copyWith(hour: starttime.hour, minute: starttime.minute);
          var endDateTime =
          date.copyWith(hour: endtime.hour, minute: endtime.minute);
          var seriesDescription = ref.read(reservationDialogDetails.seriesProvider!);
          var reservation = Reservation(
              email: reservationDialogDetails.user,
              floorDistributionId: floorDistribution.id,
              startdate: startDateTime,
              enddate: endDateTime);
          if(seriesDescription.type != SeriesType.never) {
            ref.read(reservationScreenControllerProvider.notifier)
                .createSeries(reservation: reservation, seriesDescription: seriesDescription, floorDistribution: floorDistribution);
          } else {
            ref
                .read(reservationScreenControllerProvider.notifier)
                .reserveFloorDistribution(
                floorDistribution: floorDistribution,
                reservation: reservation);
          }
        }, appLocalizations));
        break;
      case FloorDistributionReservationState
            .reservableButOwnReservationOnAnother:
        reservationDialogDetails.actions = List.empty(growable: true);
        reservationDialogDetails.actions!.add(_getSafeButton(() {
          var user = ref.read(loggedInUserProvider)!;
          var oldReservation = user
              .getReservationByFloorDistributionType(floorDistribution.type)!;
          var starttime = ref.read(reservationDialogDetails.starttimeProvider);
          var endtime = ref.read(reservationDialogDetails.endtimeProvider);
          var date = ref.read(selectedDateProvider);
          var startDateTime =
              date.copyWith(hour: starttime.hour, minute: starttime.minute);
          var endDateTime =
              date.copyWith(hour: endtime.hour, minute: endtime.minute);
          ref
              .read(reservationScreenControllerProvider.notifier)
              .updateReservation(
                  oldReservation,
                  oldReservation.copyWith(
                      floorDistributionId: floorDistribution.id,
                      startdate: startDateTime,
                      enddate: endDateTime),
                  floorDistribution);
        }, appLocalizations));
    }
    return;
  }

  static Widget _getSafeButton(
      Function()? onPressed, AppLocalizations appLocalizations) {
    return TextButton.icon(
        onPressed: onPressed != null ? () {
          onPressed.call();
          Navigator.of(navigatorKey.currentContext!).pop();
        } : null,
        icon: const Icon(Icons.check),
        label: Text(appLocalizations.reservationDialogSafe));
  }

  static Widget _getSeriesOrReservationDeleteButton(
      Function() onPressedReservation,
      Function() onPressedSeries,
      AppLocalizations appLocalizations) {

    return DropdownButtonHideUnderline(child: DropdownButton2(
      dropdownStyleData: DropdownStyleData(
        width: 250,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        offset: const Offset(0, 150),
      ),
      onChanged: (value) {
        if (value == appLocalizations.deleteSingleReservation) {
          onPressedReservation.call();
        } else {
          onPressedSeries.call();
        }
        Navigator.of(navigatorKey.currentContext!).pop();
      },
      items: [
        DropdownMenuItem(
          value: appLocalizations.deleteSingleReservation,
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete),
            const SizedBox(
              width: 8,
            ),
            Text(appLocalizations.deleteSingleReservation)
          ],
        )),
        DropdownMenuItem(
          value: appLocalizations.deleteSerial,
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.delete),
            const SizedBox(
              width: 8,
            ),
            Text(appLocalizations.deleteSerial)
          ],
        )),
      ],
      customButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.delete),
          const SizedBox(
            width: 8,
          ),
          Text(appLocalizations.reservationDialogDelete),
          const Icon(Icons.arrow_upward)
        ],
      ),
    ));
  }

  static Widget _getDeleteButton(
      Function() onPressed, AppLocalizations appLocalizations) {
    return TextButton.icon(
        onPressed: () {
          onPressed.call();
          Navigator.of(navigatorKey.currentContext!).pop();
        },
        icon: const Icon(Icons.delete),
        label: Text(appLocalizations.reservationDialogDelete));
  }

  static AutoDisposeStateProvider<DateTime> _getDateTimeProvider(
      DateTime dateTime) {
    return AutoDisposeStateProvider<DateTime>((ref) {
      return dateTime;
    });
  }

  static DateTime _getDefaultStarttime() {
    return DateTime.now().copyWith(
        hour: 7, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }

  static DateTime _getDefaultEndtime() {
    return DateTime.now().copyWith(
        hour: 20, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }

  static AutoDisposeStateProvider<SeriesDescription>
      _getDefaultSeriesDescriptionProvider() {
    return AutoDisposeStateProvider<SeriesDescription>((ref) {
      return SeriesDescription(type: SeriesType.never, until: DateTime.now());
    });
  }
}
