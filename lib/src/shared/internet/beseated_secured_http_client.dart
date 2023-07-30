import 'dart:convert';
import 'dart:io';


import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../features/authentication/data/auth_storage.dart';
import '../app_utils.dart';

class BeSeatedSecuredHttpClient{
  final String _baseUrl = AppUtils.beSeatedApiUrl;
  final AuthStorage authStorage = AuthStorage();

  Future<http.Response> get(String url) async {
    final headers = await _defaultHeaders;
    final response = await http.get(Uri.parse(_baseUrl + url), headers:headers);
    handleError(response);
    return response;
  }

  Future<http.Response> post(String url, {Object? body, bool bodyIsJson = false}) async {
    final headers = await _defaultHeaders;
    final response = await http.post(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: bodyIsJson ? jsonEncode(body) : body);
    handleError(response);
    return response;
  }

  Future<http.Response> put(String url, {Object? body, bool bodyIsJson = false}) async {
    final headers = await _defaultHeaders;
    final response = await http.put(
        Uri.parse(_baseUrl + url),
        headers: headers,
        body: bodyIsJson ? jsonEncode(body) : body);
    handleError(response);
    return response;
  }

  Future<http.Response> delete(String url) async {
    final headers = await _defaultHeaders;
    final response = await http.delete(Uri.parse(_baseUrl + url), headers: headers);
    handleError(response);
    return response;
  }

  void handleError(http.Response response) {
    if(response.statusCode == 401) {
      navigatorKey.currentContext!.go('/login');
    } else if(response.statusCode != 200) {
      throw HttpException(response.statusCode.toString());
    }
  }

  Future<String?> get _bearerToken async {
    return await authStorage.getToken();
  }

  Future<Map<String, String>> get _defaultHeaders async {
    var bearerToken = await _bearerToken;
    final headers = {
      HttpHeaders.authorizationHeader : 'Bearer $bearerToken',
      HttpHeaders.contentTypeHeader : 'application/json',
    };
    return headers;
  }
}


class UnAuthenticatedException implements Exception {
  UnAuthenticatedException();
}