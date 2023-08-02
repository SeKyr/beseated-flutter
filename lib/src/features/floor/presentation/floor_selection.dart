import 'package:beseated/src/features/floor/application/floor_service.dart';
import 'package:beseated/src/features/floor/presentation/selected_floor.dart';
import 'package:beseated/src/features/location/presentation/selected_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../domain/floor.dart';

class FloorSelection extends ConsumerWidget {
  const FloorSelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLocationId = ref.watch(selectedLocationProvider).value?.id;
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      return Container(
          child: selectedLocationId != null
              ? ref.watch(floorsByLocationIdProvider(id: selectedLocationId)).when(
              data: (floors) {
                floors.removeWhere((floor) => !floor.active);
                _setMainFloorOnFloorNull(floors: floors, ref: ref);
                return SpeedDial(
                  icon: Icons.house_siding_rounded,
                  visible: floors.isNotEmpty,
                  direction: isPortrait ? SpeedDialDirection.up : SpeedDialDirection.left,
                  children: _createButtonsForFloors(floors:floors, ref: ref),
                  tooltip: 'Stockwerke', );
                },
              error: (error, stackTrace) {
                return  Text(error.toString() + stackTrace.toString());
                },
              loading: () => const FloatingActionButton(onPressed: null, child: Icon(Icons.house_siding_rounded),)
          )
              : const FloatingActionButton(onPressed: null, materialTapTargetSize: MaterialTapTargetSize.padded, child: Icon(Icons.house_siding_rounded),)
      );
  }

  List<SpeedDialChild> _createButtonsForFloors({required List<Floor> floors, required WidgetRef ref}) {
    return floors.map((floor) => SpeedDialChild(
        child: Icon(floor.type == 'workspace' ? Icons.desktop_windows : Icons.local_parking),
        label: floor.name,
        onTap: () => ref.read(selectedFloorProvider.notifier).change(floor)
    )).toList();
  }

  _setMainFloorOnFloorNull({required List<Floor> floors, required WidgetRef ref}) {
    final mainFloor = floors.firstWhere((element) => element.main);
    Future(() {
      if(ref.read(selectedFloorProvider) == null) {
        ref.read(selectedFloorProvider.notifier).change(mainFloor);
      }
    });
  }

}