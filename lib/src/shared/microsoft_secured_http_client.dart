import 'dart:io';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:beseated/src/shared/app_utils.dart';
import 'package:http/http.dart' as http;

class MicrosoftSecuredHttpClient{

  final AadOAuth oauth = AppUtils.azureClient;

  Future<http.Response> get(String url) async {
    final headers = await _authorizationHeaders;
    final response = await http.get(Uri.parse(url), headers: headers);
    return response;
  }

  Future<http.Response> post(String url, Object body) async {
    final headers = await _authorizationHeaders;
    final response = http.post(
        Uri.parse(url),
        headers: headers,
        body: body);
    return response;
  }

  Future<http.Response> put(String url, Object body) async {
    final headers = await _authorizationHeaders;
    final response = http.put(
        Uri.parse(url),
        headers: headers,
        body: body);
    return response;
  }

  Future<http.Response> delete(String url) async {
    final headers = await _authorizationHeaders;
    final response = http.delete(Uri.parse(url), headers: headers);
    return response;
  }

  Future<String?> get _bearerToken async {
    return oauth.getAccessToken();
  }

  Future<Map<String, String>> get _authorizationHeaders async {
    var bearerToken = await _bearerToken;
    final headers = {
      HttpHeaders.authorizationHeader : 'Bearer $bearerToken',
    };
    return headers;
  }
}