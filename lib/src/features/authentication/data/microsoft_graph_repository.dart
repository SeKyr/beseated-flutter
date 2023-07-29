import 'dart:convert';

import 'package:beseated/src/features/authentication/domain/user.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/internet/microsoft_secured_http_client.dart';


part 'microsoft_graph_repository.g.dart';

class MicrosoftGraphRepository {
  MicrosoftGraphRepository({required this.client});
  final String _baseEndpointUrl = 'https://graph.microsoft.com/v1.0';

  final MicrosoftSecuredHttpClient client;

  Future<String> getProfilImage() async {
    final response = await client.get('$_baseEndpointUrl/me/photo/\$value');
    final imageBytes = response.bodyBytes;
    return base64Encode(imageBytes);
  }

  Future<User> getUser() async {
    final response = await client.get('$_baseEndpointUrl/me');
    final json = AppUtils.decodeJson(response.body);
    return User(surname: json['surname'], firstName: json['givenName'], email: json['mail']);
  }

  Future<String> getOrganizationLogo() async {
    final response = await client.get('$_baseEndpointUrl/organization');
    final json = AppUtils.decodeJson(response.body);
    return _getOrganizationLogoByTenantId(json['value'][0]['id']);

  }

  Future<String> _getOrganizationLogoByTenantId(String id) async {
    final response = await client.get('$_baseEndpointUrl/organization/$id/branding/localizations/default/bannerLogo');
    final imageBytes = response.bodyBytes;
    return base64Encode(imageBytes);
  }
}

@riverpod
MicrosoftGraphRepository microsoftGraphRepository(MicrosoftGraphRepositoryRef ref) =>
    MicrosoftGraphRepository(client: MicrosoftSecuredHttpClient());