import 'dart:convert';
import 'dart:io';

import 'package:beseated/src/shared/app_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/internet/beseated_secured_http_client.dart';

part 'login_repository.g.dart';

class LoginRepository {
  LoginRepository({required this.client});
  final String _baseEndpointUrl = '/login';

  final BeSeatedSecuredHttpClient client;
  
  Future<String> loginWithAzureToken(String token) async {
    final response = await client.post('$_baseEndpointUrl/ADToken', token);
    final json = AppUtils.decodeJson(response.body);
    return json['token'];
  }
}

@riverpod
LoginRepository loginRepository(LoginRepositoryRef ref) =>
    LoginRepository(client: BeSeatedSecuredHttpClient());