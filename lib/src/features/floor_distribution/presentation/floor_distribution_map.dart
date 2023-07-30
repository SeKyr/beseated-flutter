import 'dart:math';
import 'package:beseated/src/features/floor_distribution/presentation/floor_distribution_ui.dart';
import 'package:beseated/src/features/reservation_request/presentation/reservation_request_by_floor_distibution.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../authentication/presentation/logged_in_user.dart';
import '../../reservation/presentation/reservation_by_floor_distibution.dart';
import '../domain/floor_distribution.dart';
import 'floor_distribution_selected.dart';
import 'providable_floor_distribution_ui.dart';

typedef OnChildInteractionCallback = Function(
    FloorDistribution floorDistribution);

class FloorDistributionMap extends ConsumerWidget {
  FloorDistributionMap(
      {super.key,
      this.onReservableChildTap,
      this.onReservableChildDoubleTap,
      required this.floorDistributionsProvider});

  final _transformationController = TransformationController();

  final OnChildInteractionCallback? onReservableChildTap;

  final OnChildInteractionCallback? onReservableChildDoubleTap;

  final ProviderListenable<List<FloorDistribution>> floorDistributionsProvider;

  int height = 0;
  int width = 0;

  double availableHeight = 0;
  double availableWidth = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var floorDistributions = ref.watch(floorDistributionsProvider);
    return LayoutBuilder(builder: (context, constraints) {
      availableHeight = constraints.maxHeight;
      availableWidth = constraints.maxWidth;
      setHeightAndWidth(floorDistributions: floorDistributions);
      floorDistributions = fitFloorDistributionsToOrientation(
          floorDistributions: floorDistributions,
          maxHeigth: constraints.maxHeight,
          maxWidth: constraints.maxWidth);
      setHeightAndWidth(floorDistributions: floorDistributions);
      return GestureDetector(
          onDoubleTap: () => _handleDoubleTap,
          child: InteractiveViewer(
              constrained: false,
              transformationController: _transformationController,
              boundaryMargin: const EdgeInsets.all(1000),
              maxScale: 5,
              minScale: calculateMinScale(),
              child: Stack(children: [
                ..._createUIElementsFromFloorDistributions(
                    floorDistributions: floorDistributions
                ),
                SizedBox(width: width.toDouble(), height: height.toDouble())
              ])));
    });
  }

  List<ProvidableFloorDistributionUI> _createUIElementsFromFloorDistributions(
      {required List<FloorDistribution> floorDistributions}) {
    floorDistributions.sort((a, b) => a.z - b.z);
    return floorDistributions
        .map((floorDistribution) => ProvidableFloorDistributionUI(
            floorDistribution: floorDistribution,
            selectedProvider: floorDistributionSelectedProvider(floorDistribution.id),
            reservationProvider: reservationByFloorDistributionProvider(floorDistribution.id),
            reservationRequestProvider: reservationRequestByFloorDistributionProvider(floorDistribution.id),
            loggedInUserProvider: loggedInUserProvider,
            onTap: floorDistribution.reservable ? () => onReservableChildTap?.call(floorDistribution) : null,
            onDoubleTap: floorDistribution.reservable
                ? () => onReservableChildDoubleTap?.call(floorDistribution)
                : () => _handleDoubleTap()))
        .toList();
  }

  void setHeightAndWidth(
      {required List<FloorDistribution> floorDistributions}) {
    int width = 0;
    int height = 0;
    for (var element in floorDistributions) {
      int computedWidth = element.x + element.width;
      int computedHeight = element.y + element.height;
      width = computedWidth > width ? computedWidth : width;
      height = computedHeight > height ? computedHeight : height;
    }
    this.height = height;
    this.width = width;
  }

  void _handleDoubleTap() {
    var scale = calculateMinScale();
    _transformationController.value = Matrix4.identity()..scale(scale);
  }

  List<FloorDistribution> fitFloorDistributionsToOrientation(
      {required List<FloorDistribution> floorDistributions,
      required double maxHeigth,
      required double maxWidth}) {
    if (maxHeigth > maxWidth && height < width) {
      //screen in portrait, FloorDists in landscape
      return floorDistributions
          .map((floorDist) => floorDist.copyWith(
              x: (floorDist.y - height + floorDist.height) * (-1),
              y: floorDist.x,
              width: floorDist.height,
              height: floorDist.width))
          .toList();
    }
    if (maxHeigth < maxWidth && height > width) {
      //screen in landscape, FloorDists in portrait
      return floorDistributions
          .map((floorDist) => floorDist.copyWith(
              x: floorDist.y,
              y: width - floorDist.width - floorDist.x,
              width: floorDist.height,
              height: floorDist.width))
          .toList();
    }
    return floorDistributions;
  }

  double calculateMinScale() {
    return min(min(availableHeight / height, availableWidth / width), 1);
  }
}
