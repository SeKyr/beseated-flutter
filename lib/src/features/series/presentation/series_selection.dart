import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';


import '../../../shared/app_utils.dart';
import '../domain/series_description.dart';

class SeriesSelection extends ConsumerWidget {
  const SeriesSelection({super.key, required this.seriesDescriptionProvider});

  final AutoDisposeStateProvider<SeriesDescription> seriesDescriptionProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var appLocalizations = AppLocalizations.of(context)!;
    var seriesDescription = ref.watch(seriesDescriptionProvider);
    var weekdaysMap = _createWeekdaysMap(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if(seriesDescription.type == SeriesType.weekly && seriesDescription.weekdays.isEmpty) {
                  ref.read(seriesDescriptionProvider.notifier).state = SeriesDescription(type: SeriesType.never, until: seriesDescription.until);
                }
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(appLocalizations.reservationDialogReservationRepititionDescription)
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            DropdownButtonHideUnderline(
                child: DropdownButton2<SeriesType>(
                  items: SeriesType.values.map((st) => DropdownMenuItem(value: st, child: Text(st.getLocalizedName(appLocalizations)),)).toList(),
                  value: seriesDescription.type,
                  onChanged: (value) {
                    ref.read(seriesDescriptionProvider.notifier).state = SeriesDescription(type: value!, until: seriesDescription.until);
                  },
                )
            ),
          Consumer(builder: (context, ref, child) {
            var seriesDescription = ref.watch(seriesDescriptionProvider);
            var items = weekdaysMap.entries.map((w) => MultiSelectItem<int?>(w.key, w.value)).toList();
            return seriesDescription.type != SeriesType.never ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                seriesDescription.type == SeriesType.weekly ? MultiSelectChipField<int?>(
                  title: Text(appLocalizations.days, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
                  headerColor: Theme.of(context).colorScheme.primary,
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                  selectedChipColor: Theme.of(context).colorScheme.primary,
                  selectedTextStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  items: items,
                  initialValue: seriesDescription.weekdays,
                  onTap: (days) => ref.read(seriesDescriptionProvider.notifier).state = SeriesDescription(type: seriesDescription.type, weekdays: days.map((e) => e!).toList(), until: seriesDescription.until),
                ) : const SizedBox.shrink(),
                _getIconWithText(iconData: Icons.calendar_today, text: seriesDescription.until.toLocalDateString(context), description: appLocalizations.reservationDialogReservationRepititionUntil, onTap: () {
                  _selectDate(context, seriesDescriptionProvider, ref);
                },)
              ],
            ) : const SizedBox.shrink();
          },),
        ],
      ),
    );
  }

  Map<int, String> _createWeekdaysMap(BuildContext context) {
    Map<int, String> result = {};
    var today = DateTime.now();
    String locale = Localizations.localeOf(context).languageCode;
    var difToMonday = today.weekday - DateTime.monday;
    var monday = today.copyWith(day: today.day - difToMonday);
    for(int i = 0; i<=4; i++) {
      var weekday = monday.copyWith(day: monday.day + i);
      result[weekday.weekday] = DateFormat.EEEE(locale).format(weekday);
    }
    return result;
  }

  Widget _getIconWithText(
      {required IconData iconData,
        required String text,
        required String description,
        void Function()? onTap,
        double? width}) {
    var colorScheme = Theme.of(navigatorKey.currentContext!).colorScheme;
    var iconColor = onTap != null ? colorScheme.primary : colorScheme.onBackground;
    var iconToShow = Icon(
      iconData,
      color: iconColor,
    );
    return SizedBox(
      width: width,
      child: TextField(
        onTap: onTap,
        readOnly: true,
        decoration: InputDecoration(labelText: description, icon: iconToShow),
        controller: TextEditingController(text: text),
        style: TextStyle(
            fontSize: 13,
            color: Theme.of(navigatorKey.currentContext!)
                .colorScheme
                .onBackground),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, AutoDisposeStateProvider<SeriesDescription> seriesDescriptionProvider, WidgetRef ref) async {
    var seriesDescription = ref.read(seriesDescriptionProvider);
    var previousDate = seriesDescription.until;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: previousDate,
      firstDate: DateTime.now(),
        lastDate: DateTime(2101)
    );

    if (pickedDate != null && pickedDate != previousDate) {
      ref.read(seriesDescriptionProvider.notifier).state = SeriesDescription(type: seriesDescription.type, weekdays: seriesDescription.weekdays, until: pickedDate);
    }
  }
}