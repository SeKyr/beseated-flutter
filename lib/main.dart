import 'package:beseated/src/shared/app_utils.dart';
import 'package:beseated/src/shared/internet/is_connected.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  GoogleFonts.config.allowRuntimeFetching = false;
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
    var connectivitiyState = ref.watch(isConnectedProvider);
    builder(context, child) => _getOfflineWidget(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      builder: connectivitiyState.isLoading || connectivitiyState.value?.hasNetwork == true ?  null : (context, child) => builder(context, child),
      theme: ThemeData(
        listTileTheme: const ListTileThemeData(horizontalTitleGap: 5, minLeadingWidth: 5, ),
        primarySwatch: Colors.blue,
      ),
      routerConfig: AppUtils.router,
    );
  }

  Widget _getOfflineWidget(BuildContext context) {
    return Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.offlineMode, style: GoogleFonts.lobsterTwo(
            textStyle:
            Theme.of(context).textTheme.headlineMedium),),)
    );
  }
}
