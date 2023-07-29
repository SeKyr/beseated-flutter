
import 'package:beseated/src/features/authentication/data/auth_storage.dart';
import 'package:beseated/src/features/authentication/data/login_repository.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'microsoft_graph_service.dart';

part 'auth_service.g.dart';


class AuthService {
  AuthService({required this.loginRepository, required this.authStorage});

  final LoginRepository loginRepository;
  final AuthStorage authStorage;
  final azureClient = AppUtils.azureClient;

  Future<bool> shouldTrySilentLogin() async {
    String? tokenFromStorage = await azureClient.getAccessToken();
    if (tokenFromStorage == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> login() async {
    try {
      await azureClient.login(refreshIfAvailable: true);
      final microsoftAccessToken = await azureClient.getAccessToken();
      await loginBeSeated(microsoftAccessToken!);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> loginBeSeated(String token) async {
    final accessTokenFromCache = await authStorage.getToken();
    if (accessTokenFromCache != null) {
      return;
    }
    final accessToken = await loginRepository.loginWithAzureToken(token);
    await authStorage.setToken(accessToken);
  }

  Future<void> logout() async {
    try {
      await azureClient.logout();
      authStorage.clearToken();
    } catch (e) {
      print(e);
    }
  }
}

@riverpod
AuthService authService(AuthServiceRef ref) =>
    AuthService(loginRepository: ref.watch(loginRepositoryProvider), authStorage: AuthStorage());

@riverpod
Future<void> login(LoginRef ref) =>
    ref.watch(authServiceProvider).login();
