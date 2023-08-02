import 'package:beseated/src/shared/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppUtils.getAppBar(title: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.settings, style: TextStyle(color: Theme.of(context).colorScheme.onBackground, ),)),
      body: const Center(child: Text('Coming Soon') ,)
    );
  }

}