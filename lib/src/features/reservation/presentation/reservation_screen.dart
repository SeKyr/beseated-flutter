import 'dart:convert';

import 'package:beseated/src/features/authentication/presentation/logged_in_user.dart';
import 'package:beseated/src/features/floor_distribution/presentation/selected_floor_distribution.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_screen_controller.dart';
import 'package:beseated/src/shared/ui/notifiable_loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/app_utils.dart';
import '../../floor_distribution/presentation/floor_distribution_map.dart';
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
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
              Expanded(
              child: Align(
              alignment: Alignment.center,
                  child:_getAnimatedTitle(ref),)),
                SizedBox(
                      height: 25,
                      child: Image.memory(
                        base64Decode(user!.organizationLogo!),
                        fit: BoxFit.fitHeight,
                      )),
              ]),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.help_outline_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // do something
                  },
                )
              ]),
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
        ));
  }

  Widget _getAnimatedTitle(WidgetRef ref) {
    return Consumer(builder: (contex, ref, __) {
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
            style: const TextStyle(color: Colors.black, fontSize: 15)),
      );
    },);
  }
}
