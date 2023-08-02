import 'package:beseated/src/features/reservation_request/presentation/reservation_request_screen_controller.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:beseated/src/shared/ui/notifiable_loading_overlay_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../domain/reservation_request.dart';

class ReservationRequestsScreen extends ConsumerWidget {
  const ReservationRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppUtils.getAppBar(
            title: Text(
          AppLocalizations.of(navigatorKey.currentContext!)!
.reservationRequests,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        )),
        body: _getDatatable(ref));
  }

  Widget _getDatatable(WidgetRef ref) {
    return NotifiableLoadingOverlayView(
      notifier: reservationRequestScreenControllerProvider,
      child: Consumer(
        builder: (context, ref, __) {
          var reservationRequestsWithFloorDistributionNames =
              ref.watch(reservationRequestWithFloorDistributionNameProvider);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 1000,
                empty: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.noOpenRequests),
                columns: _getColumns(),
                rows: _getRows(reservationRequestsWithFloorDistributionNames, ref)),
          );
        },
      ),
    );
  }

  List<DataColumn2> _getColumns() {
    return [
      DataColumn2(
        label: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.id),
      ),
      DataColumn2(
        label: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.floorDistribution),
      ),
      DataColumn2(label: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.date), size: ColumnSize.S),
      DataColumn2(label: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.begin), size: ColumnSize.S),
      DataColumn2(label: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.end), size: ColumnSize.S),
      DataColumn2(
        label: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.person),
      ),
      DataColumn2(label: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.action), size: ColumnSize.M),
    ];
  }

  List<DataRow2> _getRows(
      List<ReservationRequestWithFloorDistributionName>
          reservationRequestsWithFloorDistributionNames,
      WidgetRef ref) {
    return reservationRequestsWithFloorDistributionNames
        .map((item) => DataRow2(cells: [
              DataCell(Text('${item.reservationRequest.id}')),
              DataCell(Text(item.floorDistributionName)),
              DataCell(Text(item.reservationRequest.startdate
                  .toLocalDateString(navigatorKey.currentContext!))),
              DataCell(Text(DateFormat('HH:mm')
                  .format(item.reservationRequest.startdate))),
              DataCell(Text(
                  DateFormat('HH:mm').format(item.reservationRequest.enddate))),
              DataCell(Text(item.reservationRequest.fullName)),
              DataCell(Row(children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => ref
                      .read(reservationRequestScreenControllerProvider.notifier)
                      .acceptReservationRequest(item.reservationRequest.id!),
                ),
                IconButton(
                    onPressed: () => ref
                        .read(
                            reservationRequestScreenControllerProvider.notifier)
                        .rejectReservationRequest(item.reservationRequest.id!),
                    icon: const Icon(Icons.close))
              ])),
            ]))
        .toList();
  }
}
