import 'package:beseated/src/features/location/application/location_service.dart';
import 'package:beseated/src/features/location/domain/location.dart';
import 'package:beseated/src/features/location/presentation/location_selection_controller.dart';
import 'package:beseated/src/features/location/presentation/selected_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../../shared/app_utils.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationSelection extends ConsumerWidget {
  const LocationSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(locationSelectionControllerProvider);
    return Container(
      child: state.isLoading
          ? ListTile(
              leading: const CircularProgressIndicator(),
              title: Text(AppLocalizations.of(context)!.location),
            )
          : state.hasValue
              ? ExpansionTile(
                  title: Text(AppLocalizations.of(context)!.location),
                  leading: const Icon(Icons.house),
                  children: createLocations(locations: state.value!, ref: ref, context: context),
                )
              : const ListTile(),
    );
  }

  List<ListTile> createLocations(
      {required List<Location> locations, required WidgetRef ref, required BuildContext context}) {
    return locations
        .map((l) => ListTile(
              title: GestureDetector(
                child: Text(l.name),
                onTap: () {
                  ref.read(selectedLocationProvider.notifier).change(l);
                  context.go('/reservation');
                  rootScaffoldKey.currentState!.closeDrawer();
                },
              ),
              trailing: GestureDetector(
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(left: BorderSide(color: Colors.black))),
                    child: const Icon(Icons.navigation)),
                onTap: () =>
                    MapsLauncher.launchQuery('${l.adress}, ${l.zip} ${l.city}'),
              ),
            ))
        .toList();
  }
}
