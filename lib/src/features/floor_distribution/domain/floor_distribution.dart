import 'package:beseated/src/shared/app_utils.dart';
import 'package:beseated/src/shared/converter/int_to_bool_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'floor_distribution.freezed.dart';

part 'floor_distribution.g.dart';

@freezed
class FloorDistribution with _$FloorDistribution {
  const FloorDistribution._();
  factory FloorDistribution({
    required int id,
    required String name,
    @IntToBoolConverter() required bool reservable,
    required int floorId,
    required String shape,
    String? notification,
    required FloorDistributionType type,
    required int width,
    required int height,
    required int x,
    required int y,
    required int z,
    String? owner,
  }) = _FloorDistribution;

  factory FloorDistribution.fromJson(Map<String, dynamic> json) =>
      _$FloorDistributionFromJson(json);

  String get ownerFullName {
    if (owner != null) {
      var splittedByDot = owner!.split('.');
      var prename = splittedByDot[0];
      var splittedByDotSplittedByAt = splittedByDot[1].split('@');
      var surname = splittedByDotSplittedByAt[0];
      prename = prename.capitalize();
      surname = surname.capitalize();
      return "$prename $surname";
    } else {
      return '-';
    }
  }
}

enum FloorDistributionType {
  room,
  table,
  parkingLot,
  orientation;

  String getLocalizedName(AppLocalizations localizations) {
    switch (this) {
      case FloorDistributionType.table:
        return localizations.workingDesk;
      case FloorDistributionType.parkingLot:
        return localizations.parkingLot;
      default:
        return "";
    }
  }

  IconData getIconData() {
    switch (this) {
      case FloorDistributionType.table:
        return Icons.desktop_windows;
      case FloorDistributionType.parkingLot:
        return Icons.local_parking;
      default:
        return Icons.question_mark_sharp;
    }
  }
}
