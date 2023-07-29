import 'dart:convert';
import 'dart:io';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:beseated/src/features/authentication/presentation/login_screen.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_screen.dart';
import 'package:beseated/src/features/reservation/presentation/calendar_screen.dart';
import 'package:beseated/src/features/settings/presentation/settings_screen.dart';
import 'package:beseated/src/shared/ui/custom_drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final rootScaffoldKey = GlobalKey<ScaffoldState>();

final navigatorKey = GlobalKey<NavigatorState>();
final shellKey = GlobalKey<NavigatorState>();

final localTexts = AppLocalizations.of(navigatorKey.currentContext!)!;

class AppUtils {
  static String get beSeatedApiUrl {
    const url = String.fromEnvironment('BESEATED_API_URL',
        defaultValue: 'https://beseated.com-software.de/BeSeated/api');
    return url;
  }
  static Map<String, dynamic> decodeJson(String data) => json.decode(utf8.decode(data.codeUnits)) as Map<String, dynamic>;
  static List<dynamic> decodeJsonList(String data) => json.decode(utf8.decode(data.codeUnits)) as List<dynamic>;
  static AadOAuth get azureClient {
    return AadOAuth(
        Config(
          tenant: '208bd206-c72c-483d-8a16-92e600fbfe6d',
          clientId: '7df42143-24a0-49f2-8363-290efe294b76',
          scope: 'user.read',
          redirectUri: kIsWeb
              ? 'http://localhost:8483'
              : 'https://login.live.com/oauth20_desktop.srf',
          navigatorKey: navigatorKey,
        )
    );
  }
  static GoRouter get router {
    return GoRouter(
      initialLocation: '/login',
      navigatorKey: navigatorKey,
      routes: [
        ShellRoute(
          navigatorKey: shellKey,
            pageBuilder: (context, state, child) {
            return NoTransitionPage(child: Scaffold(
              key: rootScaffoldKey,
              drawer: const CustomDrawer(),
              body: SafeArea(child: child,),
            ));
            },
            routes: [
              GoRoute(
                path: '/reservation',
                parentNavigatorKey: shellKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child:  ReservationScreen());

                },
              ),
              GoRoute(
                path: '/calendar',
                parentNavigatorKey: shellKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: CalendarScreen());
                },
              ),
              GoRoute(
                path: '/settings',
                parentNavigatorKey: shellKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: SettingsScreen());
                },
              ),
            ]
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginScreen();
          },
        ),

      ],
    );
  }

  static AppBar getAppBar({Widget? title, List<Widget>? actions}) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: title,
      leading: IconButton(
          onPressed: () => rootScaffoldKey.currentState!.openDrawer(),
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          )),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      actions: actions,
    );
  }
}