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
        onHorizontalDragEnd: (DragEndDetails details) {
          var date = ref.read(selectedDateProvider);
          if (details.primaryVelocity! > 0) {
            // swipe left to right
            date = date.subtract(const Duration(days: 1));
          } else {
            // swipe right to left
            date = date.add(const Duration(days: 1));
          }
          ref.read(selectedDateProvider.notifier).change(date);
        },
        onTap: () {
          Navigator.of(context).push(HeroDialogRoute(builder: (context) {
            return const DatepickerPopupCard();
          }, settings: const RouteSettings()));
        },
        child: SizedBox(
            width: 65,
            height: 65,
            child: FloatingActionButton(
              heroTag: _heroDatepicker,
              onPressed: null,
              child: _getIcon(65)
            ),
          )
        ),
    );
  }

  Widget _getIcon(double size) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.arrow_left, size: size * 0.3),
        Icon(Icons.calendar_today_rounded, size: size * 0.4,),
        Icon(Icons.arrow_right, size: size * 0.3,),
      ],
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
                monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: DateTime.monday),
              )
            ),
          ),
        ),
      ),
    );
  }

}