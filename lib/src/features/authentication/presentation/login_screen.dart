import 'package:beseated/src/features/authentication/presentation/login_screen_controller.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/ui/notifiable_loading_overlay_view.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotifiableLoadingOverlayView(
      notifier: loginScreenControllerProvider,
      child: Scaffold(body: LayoutBuilder(
        builder: (context, constraints) {
          var heightPerSizedBox = constraints.maxHeight / 6;
          var widthPerSizedBox = constraints.maxWidth / 2;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _welcomeSign(heightPerSizedBox, widthPerSizedBox),
              SizedBox(
                height: constraints.maxHeight / 2,
                child: Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(FontAwesome5.microsoft),
                    label: Text(AppLocalizations.of(context)!.microsoftLogin),
                    onPressed: () {
                      ref
                          .read(loginScreenControllerProvider.notifier)
                          .loginAndRedirectOnSuccess();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }

  Widget _welcomeSign(double heightPerSizedBox, double widthPerSizedBox) {
    var textStyle = GoogleFonts.lobsterTwo(
        textStyle:
            Theme.of(navigatorKey.currentContext!).textTheme.headlineMedium);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: widthPerSizedBox,
                  height: heightPerSizedBox,
                  child: Center(
                    child: Text(localTexts.welcome, style: textStyle),
                  ),
                ),
                SizedBox(
                  width: widthPerSizedBox,
                  height: heightPerSizedBox,
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: widthPerSizedBox, height: heightPerSizedBox),
                SizedBox(
                  width: widthPerSizedBox,
                  height: heightPerSizedBox,
                  child: Center(child: Text(localTexts.to, style: textStyle)),
                )
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: widthPerSizedBox,
                  height: heightPerSizedBox,
                  child: Center(
                    child: Image.asset('assets/images/beseated-logo.png'),
                  ),
                ),
                SizedBox(width: widthPerSizedBox, height: heightPerSizedBox)
              ],
            ),
          ],
        );
      },
    );
  }
}
