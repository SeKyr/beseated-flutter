import 'package:beseated/src/shared/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppUtils.getAppBar(title: const Text('Einstellungen', style: TextStyle(color: Colors.black, ),)),
      body: Text('Coming Soon')
    );
  }

}