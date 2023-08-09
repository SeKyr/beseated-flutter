import 'dart:convert';

import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/features/authentication/presentation/logged_in_user.dart';
import 'package:beseated/src/features/floor/presentation/selected_floor.dart';
import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
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
                  _getUtilizationWidgets()
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
                ref.read(reservationScreenControllerProvider.notifier).showFloorDistributionPopup(floorDistribution);
              },
              onReservableChildDoubleTap: (floorDistribution) => ref
                  .read(reservationScreenControllerProvider.notifier)
                  .doFloorDistributionQuickActionOnValidDate(floorDistribution),
            ),
          ),
          floatingActionButton: const FloatingActionButtonColumn(),
          bottomNavigationBar: _getBottomAppBar(),
        ));
  }

  Widget _getUtilizationWidgets() {
    return Consumer(builder: (context, ref, __) {
      var details = ref.watch(reservationScreenUtilizationWidgetDetailsProvider);
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.desktop_windows_outlined, size: 15, color: Theme.of(context).colorScheme.onBackground,),
          const SizedBox(width: 2,),
          _getUtilizationWidget(details, FloorDistributionType.table),
          const SizedBox(width: 5,),
          Icon(Icons.local_parking, size: 15, color: Theme.of(context).colorScheme.onBackground,),
          const SizedBox(width: 2,),
          _getUtilizationWidget(details, FloorDistributionType.parkingLot),
        ],
      );
    },);
  }

  Widget _getUtilizationWidget(UtilizationWidgetDetails details, FloorDistributionType type) {
    var actual = 0;
     int? max;
    if (type == FloorDistributionType.parkingLot) {
      actual = details.parkingLotActual;
      max = details.parkingLotMax;
    } else if (type == FloorDistributionType.table) {
      actual = details.workingPlaceActual;
      max = details.workingPlaceMax;
    }

    double percent = max != null ? actual / max : 0;

    Color progressColor = details.firstStageColor;

    if (percent >= details.firstBorder) {
      if (percent >= details.secondBorder) {
        progressColor = details.thirdStageColor;
      } else {
        progressColor = details.secondStageColor;
      }
    }

    return CircularPercentIndicator(
        radius: 25.0,
        percent: percent,
        center: Text(
            max != null ? "$actual/$max": "$actual",
            style: const TextStyle(fontSize: 8)
        ),
        progressColor: progressColor,
      backgroundColor: details.backgroundColor,
    );

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
          children: [
              Expanded(
            child: SizedBox(height: 48,
            child: _bottomAppBarBodyNotScrollable(ref, context, user)
            )),
            CustomPopupMenu(
                arrowColor: Theme.of(context).colorScheme.background,
                position: PreferredPosition.top,
                arrowSize: 20,
                menuBuilder: () {
                  return const ReservationsLegend();
                },
                pressType: PressType.singleClick,
                child: IconButton(
                  icon: Icon(
                    Icons.help_outline_rounded,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  onPressed: null,
                ))
          ],
        ));
      },
    );
  }

  Widget _bottomAppBarBodyNotScrollable(WidgetRef ref, BuildContext context, User user) {
    return LayoutBuilder(builder: (context, constraints) {
      var size = constraints.maxWidth / 2;
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _getOwnReservationDisplay(Icons.desktop_windows,
              user.workingPlaceReservationAndFloorDistribution, ref, context, size: size),
          _getOwnReservationDisplay(Icons.local_parking,
              user.parkingLotReservationAndFloorDistribution, ref, context, size: size),
        ],
      );
    },);
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
      WidgetRef ref, BuildContext context, {double? size}) {
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
          color: onPressed == null ? Theme.of(context).disabledColor : Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(
          width: 2,
          height: 0,
        ),
        Container(
          constraints: size != null ? BoxConstraints(maxWidth: size - 4 - 24 - 48) : null,
          child: Text(
            reservationAndFloorDistribution?.floorDistribution.name ??
                AppLocalizations.of(navigatorKey.currentContext!)!
.noReservation,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize:10),
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
          color: Theme.of(context).colorScheme.primary,
          disabledColor: Theme.of(context).disabledColor,
        )
      ],
    );
  }
}
