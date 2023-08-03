import 'dart:convert';

import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/features/authentication/presentation/logged_in_user.dart';
import 'package:beseated/src/features/floor/presentation/selected_floor.dart';
import 'package:beseated/src/features/floor_distribution/presentation/selected_floor_distribution.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_screen_controller.dart';
import 'package:beseated/src/features/reservation/presentation/reservations_legend.dart';
import 'package:beseated/src/features/reservation/presentation/selected_date.dart';
import 'package:beseated/src/shared/ui/notifiable_loading_overlay_view.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../shared/app_utils.dart';
import '../../floor_distribution/presentation/floor_distribution_map.dart';
import 'floating_action_button_column.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ReservationScreen extends ConsumerWidget {
  const ReservationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.read(loggedInUserProvider);
    return NotifiableLoadingOverlayView(
        notifier: reservationScreenControllerProvider,
        child: Scaffold(
          appBar: AppUtils.getAppBar(
              title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Expanded(
                    child: Align(
                  alignment: Alignment.center,
                  child: _getAnimatedTitle(ref),
                )),
                SizedBox(
                    height: 25,
                    child: Image.memory(
                      base64Decode(user!.organizationLogo!),
                      fit: BoxFit.fitHeight,
                    )),
              ]),
              actions: []),
          body: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              centerTitle: true,
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _getDateDisplay(),
                      const SizedBox(height: 10,),
                      _getFloorDisplay(),
                    ],
                  ),
                  const SizedBox(width: 15,),
                  Icon(Icons.desktop_windows_outlined, size: 15, color: Theme.of(context).colorScheme.onBackground,),
                  const SizedBox(width: 2,),
                  CircularPercentIndicator(radius: 25.0, percent: 0.7, center: const Text("7/10", style: TextStyle(fontSize: 8),)),
                  const SizedBox(width: 5,),
                  Icon(Icons.local_parking, size: 15, color: Theme.of(context).colorScheme.onBackground,),
                  const SizedBox(width: 2,),
                  CircularPercentIndicator(radius: 25.0, percent: 0.7, center: const Text("7/10", style: TextStyle(fontSize: 8))),
                ],
              ),
/*              actions: [
                _getLastReloadedDisplay()

              ],*/
            ),
            body: FloorDistributionMap(
              floorDistributionsProvider:
              reservationScreenFloorDistributionsProvider,
              onReservableChildTap: (floorDistribution) {
                ref
                    .read(selectedFloorDistributionProvider.notifier)
                    .change(floorDistribution);
              },
              onReservableChildDoubleTap: (floorDistribution) => ref
                  .read(reservationScreenControllerProvider.notifier)
                  .handleFloorDistributionDoubleTap(floorDistribution),
            ),
          ),
          floatingActionButton: const FloatingActionButtonColumn(),
          bottomNavigationBar: _getBottomAppBar(),
        ));
  }

  Widget _getAnimatedTitle(WidgetRef ref) {
    return Consumer(
      builder: (context, ref, __) {
        var title = ref.watch(reservationScreenTitleProvider);
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Text(title,
              // This key causes the AnimatedSwitcher to interpret this as a "new"
              // child each time the count changes, so that it will begin its animation
              // when the count changes.
              key: ValueKey<String>(title),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 15)),
        );
      },
    );
  }

  Widget _getBottomAppBar() {
    return Consumer(
      builder: (context, ref, _) {
        var user = ref.watch(loggedInUserProvider)!;
        return BottomAppBar(
            child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
              Expanded(
            child: SizedBox(height: 48,
            child:  Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _getOwnReservationDisplay(Icons.desktop_windows,
                      user.workingPlaceReservationAndFloorDistribution, ref, context),
                  _getOwnReservationDisplay(Icons.local_parking,
                      user.parkingLotReservationAndFloorDistribution, ref, context),
                ],
              ),),
            )),
            CustomPopupMenu(
                arrowColor: Theme.of(context).colorScheme.background,
                position: PreferredPosition.top,
                arrowSize: 20,
                menuBuilder: () {
                  return const ReservationsLegend();
                },
                pressType: PressType.singleClick,
                child: const IconButton(
                  icon: Icon(
                    Icons.help_outline_rounded,
                    color: Colors.black,
                  ),
                  onPressed: null,
                ))
          ],
        ));
      },
    );
  }

  Widget _getDateDisplay() {
    return Consumer(
      builder: (context, ref, _) {
        var date = ref.watch(selectedDateProvider);
        return _getIconWithText(
            iconData: Icons.calendar_today, text: date.toLocalDateString(context));
      },
    );
  }

  Widget _getFloorDisplay() {
    return Consumer(
      builder: (context, ref, _) {
        var floor = ref.watch(selectedFloorProvider);
        return _getIconWithText(
            iconData: Icons.house_siding_rounded, text: floor?.name ?? "");
      },
    );
  }

  Widget _getLastReloadedDisplay() {
    return Consumer(
      builder: (context, ref, _) {
        var lastTimeReloaded = ref.watch(lastTimeReloadedProvider);
        var text = lastTimeReloaded.isLoading ? "" : lastTimeReloaded.value!.toLocalTimeString(context);
        return _getIconWithText(
            iconData: Icons.refresh, text: text, loading: lastTimeReloaded.isLoading, textWidth: 60);
      },
    );
  }

  Widget _getIconWithText({required IconData iconData, required String text, bool loading = false, double textWidth = 100}) {
    var iconToShow = loading ? const SizedBox(width: 15, height: 15, child: CircularProgressIndicator(),): Icon(iconData, size: 15, color: Theme.of(navigatorKey.currentContext!).colorScheme.onBackground,);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconToShow,
        const SizedBox(
          width: 2,
          height: 0,
        ),
        Text(
            text,
            style: TextStyle(fontSize: 13, color: Theme.of(navigatorKey.currentContext!).colorScheme.onBackground),
          ),
      ],
    );
  }

  Widget _getOwnReservationDisplay(
      IconData iconData,
      ReservationAndFloorDistribution? reservationAndFloorDistribution,
      WidgetRef ref, BuildContext context) {
    var onPressed = reservationAndFloorDistribution != null
        ? () => AppUtils.showConfirmDialog(
            AppLocalizations.of(navigatorKey.currentContext!)!
.youSure,
            () => ref
                .read(reservationScreenControllerProvider.notifier)
                .deleteReservation(reservationAndFloorDistribution.reservation,
                    reservationAndFloorDistribution.floorDistribution))
        : null;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          iconData,
          size: 13,
          color: onPressed == null ? Theme.of(context).disabledColor : Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          width: 2,
          height: 0,
        ),
        SizedBox(
          width: 80,
          child: Text(
            reservationAndFloorDistribution?.floorDistribution.name ??
                AppLocalizations.of(navigatorKey.currentContext!)!
.noReservation,
            style: const TextStyle(fontSize: 8),
          ),
        ),
        const SizedBox(
          width: 2,
          height: 0,
        ),
        IconButton(
          onPressed: onPressed,
          icon: const Icon(
            Icons.delete,
          ),
          iconSize: 13,
          color: Theme.of(context).colorScheme.primary,
          disabledColor: Theme.of(context).disabledColor,
        )
      ],
    );
  }
}
