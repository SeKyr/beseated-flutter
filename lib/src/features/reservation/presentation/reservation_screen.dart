import 'dart:convert';

import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/features/authentication/presentation/logged_in_user.dart';
import 'package:beseated/src/features/floor_distribution/presentation/selected_floor_distribution.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_screen_controller.dart';
import 'package:beseated/src/features/reservation/presentation/reservations_legend.dart';
import 'package:beseated/src/shared/ui/notifiable_loading_overlay_view.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/app_utils.dart';
import '../../floor_distribution/domain/floor_distribution.dart';
import '../../floor_distribution/presentation/floor_distribution_map.dart';
import '../domain/reservation.dart';
import 'floating_action_button_column.dart';

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
          floatingActionButton: const FloatingActionButtonColumn(),
          bottomNavigationBar: BottomAppBar(
              color: globalTheme.colorScheme.background,
              child: _getBottomAppBar()),
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
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              _getOwnReservationDisplay( const Icon( Icons.desktop_windows, size: 15,),
                  user.workingPlaceReservationAndFloorDistribution, ref),
              _getOwnReservationDisplay( const Icon(Icons.local_parking, size: 15,),
                  user.parkingLotReservationAndFloorDistribution, ref),
            ],),
            const Spacer(),
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

  Widget _getOwnReservationDisplay(
      Icon icon, ReservationAndFloorDistribution? reservationAndFloorDistribution, WidgetRef ref) {
    var onPressed = reservationAndFloorDistribution != null ?
        () => AppUtils.showConfirmDialog(localTexts.youSure, () =>
            ref.read(reservationScreenControllerProvider.notifier).deleteReservation(reservationAndFloorDistribution.reservation, reservationAndFloorDistribution.floorDistribution))
        : null;
    return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(
              width: 2,
              height: 0,
            ),
            SizedBox(
              width: 115,
              child: Text(reservationAndFloorDistribution?.floorDistribution.name ?? localTexts.noReservation, style: TextStyle(fontSize: 13),),
            ),
            const SizedBox(
              width: 2,
              height: 0,
            ),
            IconButton(onPressed: onPressed, icon: const Icon(Icons.delete,), iconSize: 15,)
          ],
        );
  }
}
