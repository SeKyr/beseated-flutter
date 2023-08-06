import 'dart:convert';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:beseated/src/features/authentication/presentation/login_screen.dart';
import 'package:beseated/src/features/reservation/presentation/reservation_screen.dart';
import 'package:beseated/src/features/reservation_request/presentation/assigned_reservation_requests_badge.dart';
import 'package:beseated/src/features/reservation_request/presentation/reservation_requests_screen.dart';
import 'package:beseated/src/features/settings/presentation/settings_screen.dart';
import 'package:beseated/src/shared/ui/custom_drawer.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

final rootScaffoldKey = GlobalKey<ScaffoldState>();

final navigatorKey = GlobalKey<NavigatorState>();
final shellKey = GlobalKey<NavigatorState>();


class AppUtils {
  static String get beSeatedApiUrl {
    const url = String.fromEnvironment('BESEATED_API_URL',
        defaultValue: 'https://beseated.com-software.de/BeSeated/api');
    return url;
  }

  static Map<String, dynamic> decodeJson(String data) =>
      json.decode(utf8.decode(data.codeUnits)) as Map<String, dynamic>;

  static List<dynamic> decodeJsonList(String data) =>
      json.decode(utf8.decode(data.codeUnits)) as List<dynamic>;

  static AadOAuth get azureClient {
    return AadOAuth(Config(
      tenant: '208bd206-c72c-483d-8a16-92e600fbfe6d',
      clientId: '7df42143-24a0-49f2-8363-290efe294b76',
      scope: 'user.read',
      redirectUri: kIsWeb
          ? 'http://localhost:8483'
          : 'https://login.live.com/oauth20_desktop.srf',
      navigatorKey: navigatorKey,
    ));
  }

  static GoRouter get router {
    return GoRouter(
      initialLocation: '/login',
      navigatorKey: navigatorKey,
      routes: [
        ShellRoute(
            navigatorKey: shellKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(
                  child: Scaffold(
                key: rootScaffoldKey,
                drawer: const CustomDrawer(),
                body: SafeArea(
                  child: child,
                ),
              ));
            },
            routes: [
              GoRoute(
                path: '/reservation',
                parentNavigatorKey: shellKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: ReservationScreen());
                },
              ),
              GoRoute(
                path: '/settings',
                parentNavigatorKey: shellKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(child: SettingsScreen());
                },
              ),
              GoRoute(
                path: '/reservation-requests',
                parentNavigatorKey: shellKey,
                pageBuilder: (BuildContext context, GoRouterState state) {
                  return const NoTransitionPage(
                      child: ReservationRequestsScreen());
                },
              ),
            ]),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
        ),
      ],
    );
  }

  static AppBar getAppBar({Widget? title, List<Widget>? actions}) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: title,
      leading: _getAppBarLeading(),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      titleSpacing: 0,
      actions: actions,
    );
  }

  static Widget _getAppBarLeading() {
    return IconButton(
        onPressed: () => rootScaffoldKey.currentState!.openDrawer(),
        icon: const AssignedReservationRequestsBadge(
            child: Icon(
              Icons.menu,
              color: Colors.black,
            )
        )
    );
  }

  static void showConfirmDialog(String content, Function() onAccept) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.pleaseConfirm),
            content: Text(content),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    onAccept.call();
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.yesLarge)),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(navigatorKey.currentContext!)!
.noLarge))
            ],
          );
        });
  }

  static void showSuccessToast(String text) {
    CherryToast.success(
      title: Text(text),
      toastPosition: Position.bottom,
      animationType: AnimationType.fromBottom,
      animationDuration: const Duration(milliseconds: 200),
      toastDuration: const Duration(seconds: 1, milliseconds: 500),
    ).show(navigatorKey.currentContext!);
  }

  static void showErrorToast() {
    CherryToast.error(
      title:
      Text(AppLocalizations.of(navigatorKey.currentContext!)!.errorToast),
      toastPosition: Position.bottom,
      animationType: AnimationType.fromBottom,
      animationDuration: const Duration(milliseconds: 200),
      toastDuration: const Duration(seconds: 1, milliseconds: 500),
    ).show(navigatorKey.currentContext!);
  }
  
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension DateTimeExtension on DateTime {
  String toLocalDateString(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'de':
        return DateFormat('dd.MM.yyyy').format(this);
      default:
        return DateFormat('MM-dd-yyyy').format(this);
    }
  }

  String toLocalTimeString(BuildContext context) {
    String locale = Localizations.localeOf(context).languageCode;
    switch (locale) {
      case 'de':
        return DateFormat('HH:mm:ss').format(this);
      default:
        return DateFormat('hh:mm:ss a').format(this);
    }
  }
}
