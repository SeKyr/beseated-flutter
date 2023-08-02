import 'package:beseated/src/features/floor_distribution/domain/floor_distribution.dart';
import 'package:beseated/src/features/floor_distribution/presentation/floor_distribution_ui.dart';
import 'package:beseated/src/features/reservation_request/domain/reservation_request.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../domain/reservation.dart';

class ReservationsLegend extends StatelessWidget {
  const ReservationsLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Theme.of(context).colorScheme.background),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _createListTiles(context),
      ),
    );
  }

  List<Widget> _createListTiles(BuildContext context) {
    var list = List.of(_createListTilesForFloorDistributions());
    list.addAll(_createListTilesForActions(context));
    return list;
  }

  List<Widget> _createListTilesForFloorDistributions() {
    List<Widget> list = List.empty(growable: true);
    _createFloorDistributionLegendEntrys().forEach((entry) {
      list.add(_createListTileFromFloorDistributionLegendEntry(entry));
    });
    return list;
  }

  List<Widget> _createListTilesForActions(BuildContext context) {
    List<Widget> list = List.empty(growable: true);
    list.add(_createLegendEntryForAction( badges.Badge(
      badgeContent: const Text('2x'),
      position: badges.BadgePosition.topStart(start: -15),
      badgeAnimation: const badges.BadgeAnimation.slide(toAnimate: false),
      badgeStyle: const badges.BadgeStyle(
        badgeColor: Colors.transparent
      ),
      child: const Icon(Icons.touch_app),
    ), AppLocalizations.of(navigatorKey.currentContext!)!
.quickAction));
    return list;
  }

  Widget _createLegendEntryForAction(Widget widget, String description) {
    return _createListTileForLegend(
      SizedBox(
        width: 40,
        height: 20,
        child: Center(child: widget,)
      ), Text(description)
    );
  }

  List<FloorDistributionLegendEntry> _createFloorDistributionLegendEntrys() {
    var floorDistribution = FloorDistribution(
        id: 1,
        name: "Legend",
        reservable: true,
        floorId: 1,
        shape: "",
        type: FloorDistributionType.table,
        width: 40,
        height: 20,
        x: 0,
        y: 0,
        z: 0);
    var reservation = Reservation(
        email: "max.mustermann@company.domain",
        roomId: 1,
        startdate: DateTime.now(),
        enddate: DateTime.now());
    var reservationRequest = ReservationRequest(email: "max.mustermann@company.domain", roomId: 1, startdate: DateTime.now(), enddate: DateTime.now());
    List<FloorDistributionLegendEntry> list = List.empty(growable: true);
    list.add(FloorDistributionLegendEntry(
        floorDistribution: floorDistribution.copyWith(reservable: false),
        userEmail: "",
        description: AppLocalizations.of(navigatorKey.currentContext!)!
.notReservable));
    list.add(FloorDistributionLegendEntry(
        floorDistribution: floorDistribution,
        userEmail: "",
        description: AppLocalizations.of(navigatorKey.currentContext!)!
.notReserved));
    list.add(FloorDistributionLegendEntry(
        floorDistribution: floorDistribution,
        reservation: reservation,
        userEmail: "",
        description: AppLocalizations.of(navigatorKey.currentContext!)!
.reserved));
    list.add(FloorDistributionLegendEntry(
        floorDistribution: floorDistribution,
        reservation: reservation,
        userEmail: "max.mustermann@company.domain",
        description: AppLocalizations.of(navigatorKey.currentContext!)!
.selfReserved));
    list.add(FloorDistributionLegendEntry(
        floorDistribution: floorDistribution,
        reservationRequest: reservationRequest,
        userEmail: "max.mustermann@company.domain",
        description: AppLocalizations.of(navigatorKey.currentContext!)!
.requested));
    return list;
  }

  Widget _createListTileFromFloorDistributionLegendEntry(
      FloorDistributionLegendEntry entry) {
    return _createListTileForLegend(
        Stack(children: [
          FloorDistributionUI(
            floorDistribution: entry.floorDistribution,
            selected: false,
            loggedInUserEmail: entry.userEmail,
            reservation: entry.reservation,
            reservationRequest: entry.reservationRequest,
          ),
          SizedBox(
              width: entry.floorDistribution.width.toDouble(),
              height: entry.floorDistribution.height.toDouble())
        ]),
        Text(entry.description));
  }

  Widget _createListTileForLegend(Widget leading, Widget title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          const SizedBox(width: 4,),
          title
        ],
      ),
    );
  }
}

class FloorDistributionLegendEntry {
  FloorDistributionLegendEntry(
      {required this.floorDistribution,
      this.reservation,
      this.reservationRequest,
      required this.userEmail,
      required this.description});

  FloorDistribution floorDistribution;
  Reservation? reservation;
  ReservationRequest? reservationRequest;
  String userEmail;
  String description;
}
