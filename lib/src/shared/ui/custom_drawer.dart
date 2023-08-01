import 'dart:convert';

import 'package:beseated/src/features/authentication/application/auth_service.dart';
import 'package:beseated/src/features/location/presentation/location_selection.dart';
import 'package:beseated/src/features/reservation_request/presentation/assigned_reservation_requests_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/authentication/presentation/logged_in_user.dart';

import '../app_utils.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(loggedInUserProvider);
    final userAccountsDrawerHeader = user != null
        ? UserAccountsDrawerHeader(
            accountName: Text('${user.firstName} ${user.surname}'),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: user.image == null
                    ? Image.asset(
                        'assets/images/profile-dummy.png',
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      )
                    : Image.memory(
                        base64Decode(user.image!),
                        fit: BoxFit.cover,
                        width: 90,
                        height: 90,
                      ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: Image.asset('assets/images/nav-bar-img.jpg').image),
            ),
          )
        : const Text('Account konnte nicht geladen werden');
    return Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          userAccountsDrawerHeader,
          _getNavBarBody(ref, context),
          _getFooter(ref, context),
        ],
      ),
    );
  }

  void _logout(WidgetRef ref, BuildContext context) async {
    await ref.read(authServiceProvider).logout();
    context.go("/login");
  }

  Widget _getNavBarBody(WidgetRef ref, BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      children: [
        const LocationSelection(),
        _getReservationRequestListTile(context)
      ],
    )));
  }

  Widget _getReservationRequestListTile(BuildContext context) {
    return ListTile(
      onTap: () {
        context.go("/reservation-requests");
        rootScaffoldKey.currentState!.closeDrawer();
      },
      leading: const Icon(Icons.assignment),
      title: AssignedReservationRequestsBadge(
          child: Text(localTexts.reservationRequests,)),
    );
  }

  Widget _getFooter(WidgetRef ref, BuildContext context) {
    return Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  onTap: () => _logout(ref, context),
                  leading: const Icon(Icons.logout),
                  title: Text(localTexts.logout),
                ),
              ),
              Expanded(
                child: ListTile(
                  onTap: () {
                    context.go("/settings");
                    rootScaffoldKey.currentState!.closeDrawer();
                  },
                  leading: const Icon(Icons.settings),
                  title: Text(localTexts.settings),
                ),
              ),
            ],
          )),
    );
  }
}
