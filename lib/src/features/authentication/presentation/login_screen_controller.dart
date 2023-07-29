import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/app_utils.dart';
import '../application/auth_service.dart';
import '../application/microsoft_graph_service.dart';

part 'login_screen_controller.g.dart';

@riverpod
class LoginScreenController extends _$LoginScreenController {

  @override
  FutureOr<bool> build() async {
    var shouldTrySilentLogin = await ref.watch(authServiceProvider).shouldTrySilentLogin();
    if(shouldTrySilentLogin) {
      await loginAndRedirectOnSuccess();
      return false;
    }
    return true;
  }

  Future<void> loginAndRedirectOnSuccess() async {
    state = const AsyncLoading();
    var result = await  _loginAndLoadUserDetails();
    if(result) {
      navigatorKey.currentContext!.go('/reservation');
    } else {
      state = const AsyncData(true);
    }
  }

  Future<bool> _loginAndLoadUserDetails() async {
    try {
      await ref.read(authServiceProvider).login(); //TODO: Durch login mit oauth2_client ersetzen
      await ref.read(microsoftGraphServiceProvider).loadUserDetails();
      return true;
    } catch (e) {
      return false;
    }
  }
}