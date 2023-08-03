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
    final emptyFloatingActionButton = SizedBox(height: 65, width: 65, child: FittedBox(child: FloatingActionButton(onPressed: null, child: _getIcon(56),),),);
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
      return Container(
          child: selectedLocationId != null
              ? ref.watch(floorsByLocationIdProvider(id: selectedLocationId)).when(
              data: (floors) {
                floors.removeWhere((floor) => !floor.active);
                floors.sort((a, b) => a.id-b.id,);
                var mainFloor = _getMainFloorOrFirst(floors: floors);
                _setFirstDisplayFloorOnSelectedFloorNull(firstFloorToDisplay: mainFloor, ref: ref);
                var swipeIndex = floors.indexOf(mainFloor);
                return GestureDetector(
                    onHorizontalDragEnd: (DragEndDetails details) {
                      if (details.primaryVelocity! > 0) {
                        // swipe left to right
                        if(swipeIndex > 0) {
                          swipeIndex--;
                        } else {
                          swipeIndex = floors.length - 1;
                        }
                      } else {
                        // swipe right to left
                        if(swipeIndex < floors.length - 1) {
                          swipeIndex++;
                        } else {
                          swipeIndex = 0;
                        }
                      }
                      ref.read(selectedFloorProvider.notifier).change(floors[swipeIndex]);
                    },
                  child: SpeedDial(
                    buttonSize: const Size(65, 65),
                    visible: floors.isNotEmpty,
                    direction: isPortrait ? SpeedDialDirection.up : SpeedDialDirection.left,
                    children: _createButtonsForFloors(floors:floors, ref: ref),
                    tooltip: 'Stockwerke',
                    child: _getIcon(56), ),
                );
                },
              error: (error, stackTrace) {
                return  Text(error.toString() + stackTrace.toString());
                },
              loading: () => emptyFloatingActionButton
          )
              : emptyFloatingActionButton
      );
  }

  Widget _getIcon(double size) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_left, size: size * 0.3),
        Icon(Icons.house_siding_rounded, size: size * 0.4,),
        Icon(Icons.arrow_right, size: size * 0.3,),
      ],
    );
  }

  List<SpeedDialChild> _createButtonsForFloors({required List<Floor> floors, required WidgetRef ref}) {
    return floors.map((floor) => SpeedDialChild(
        child: Icon(floor.type == 'workspace' ? Icons.desktop_windows : Icons.local_parking),
        label: floor.name,
        onTap: () => ref.read(selectedFloorProvider.notifier).change(floor)
    )).toList();
  }

  Floor _getMainFloorOrFirst({required List<Floor> floors}) {
    return floors.firstWhere((element) => element.main, orElse: () => floors.first);
  }

  void _setFirstDisplayFloorOnSelectedFloorNull({required Floor firstFloorToDisplay, required WidgetRef ref}) {
    Future(() {
      if(ref.read(selectedFloorProvider) == null) {
        ref.read(selectedFloorProvider.notifier).change(firstFloorToDisplay);
      }
    });
  }

}