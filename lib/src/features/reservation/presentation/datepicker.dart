import 'package:beseated/src/features/reservation/presentation/selected_date.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../shared/ui/custom_rect_tween.dart';
import '../../../shared/ui/hero_dialog_route.dart';

class Datepicker extends ConsumerWidget {
  const Datepicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const DatepickerPopupCard();
          }, settings: const RouteSettings()));
        },
        child: Hero(
          tag: _heroDatepicker,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Container(
              child: const Icon(Icons.calendar_today_rounded),
              width: 56,
              height: 56,
            ),
          ),
        ),
      ),
    );
  }
}

const String _heroDatepicker = 'datepicker-hero';

class DatepickerPopupCard extends ConsumerWidget {
  const DatepickerPopupCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDateProvider);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroDatepicker,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin!, end: end!);
          },
          child: Material(
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.single,
                onSelectionChanged: (dateArgs) {
                  ref.read(selectedDateProvider.notifier).change(dateArgs.value);
                  Navigator.of(context).pop();
                  },
                initialSelectedDate: date,
                initialDisplayDate: date,
                showNavigationArrow: true,
              )
            ),
          ),
        ),
      ),
    );
  }

}