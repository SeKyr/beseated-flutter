import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {

  final _storage = const FlutterSecureStorage(
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final tokenKey = 'beseated_token';

  Future<void> setToken(String token) async {
    try {
      await _storage.write(key: tokenKey, value: token);
    } catch (e) {
      print(e);
    }
  }

  Future<String?> getToken() async {
    String? token;
    try {
      token = await _storage.read(key: tokenKey);
    } catch(e) {
      print(e);
    }
    return token;
  }

  Future<void> clearToken() async {
    try {
      await _storage.delete(key: tokenKey);
    } catch (e) {
      print(e);
    }
  }
}
