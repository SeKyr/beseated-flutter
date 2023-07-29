import 'package:beseated/src/shared/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main() {
  runApp(const ProviderScope( child: BeSeated()));
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };
}

class BeSeated extends ConsumerWidget {
  const BeSeated({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(horizontalTitleGap: 5, minLeadingWidth: 5, ),
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppUtils.router,
    );
  }
}
