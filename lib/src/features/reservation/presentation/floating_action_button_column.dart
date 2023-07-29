import 'package:beseated/src/features/floor/presentation/floor_selection.dart';
import 'package:beseated/src/features/reservation/presentation/datepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloatingActionButtonColumn extends ConsumerWidget {
  const FloatingActionButtonColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Wrap(
      direction: Axis.vertical,
      children: [
        FloorSelection(),
        Datepicker()
      ],
    );
  }

}